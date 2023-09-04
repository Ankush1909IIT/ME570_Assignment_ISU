#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <algorithm>
#include <time.h>

using namespace std;

#define cudaCheckError() {																\
	cudaError_t e=cudaGetLastError();													\
	if(e!=cudaSuccess) {																\
		printf("Cuda failure %s:%d: '%s'\n",__FILE__,__LINE__,cudaGetErrorString(e));	\
		}																					\
}


inline int GetBlockSize(int b, int maxSize)
{
	if (b <= maxSize)
		return b;
	else
		return maxSize;
}


inline int GetGridSize(int n, int b)
{
	if (n%b == 0)
		return n / b;
	else
		return int(n*1.0 / (b*1.0)) + 1;
}

__device__ float EvalMaxGPU(float a, float b) {
	return ((a) > (b)) ? (a) : (b);
}

__global__ void FindMax4(float *in, float *out, int n)
{
	int i = blockIdx.x*blockDim.x + threadIdx.x;
	int j = blockIdx.y*blockDim.y + threadIdx.y;

	if (i < n && j < n)
	{
		// Output index
		int index = j * n + i;
	

		// Input index
		// Set up the input index correctly for the 4 inputs
		int index1 = i*j;
		int index2 = i*j+n/2;
		int index3 = i*j+n*n/2;
		int index4 = i*j+n*n/2 + n/2;
		
		//int index1 = i*j;
		//int index2 = i*j +1;
		//int index3 = i*j + n;
		//int index4 = i*j + n+1;
		// Compute the max of 4 values
		float max1 = EvalMaxGPU(in[index1], in[index2]);
		float max2 = EvalMaxGPU(in[index3], in[index4]);
		float max = EvalMaxGPU(max1, max2);
		out[index] = max;
	}
}

void InitMatrix(float* a, int n, int m)
{
	srand((int)time(NULL));
	for (int j = 0; j < m; j++)
		for (int i = 0; i < n; i++)
			a[j*n + i] = float(10.0 * rand() / (RAND_MAX*1.0));
	
	// Use the code below for debugging if required
		//a[j*n + i] = j*n + i;

}

void PrintMatrix(float* a, int n, int m)
{
	for (int j = 0; j < m; j++)
	{
		for (int i = 0; i < n; i++)
			cout << a[j*n + i] << " ";
		cout << endl;
	}
}
float FindMaxCPU(float* a, int n, int m)
{ 
	float maxVal = 0;
	for (int j = 0; j < m; j++)
		for (int i = 0; i < n; i++)
			maxVal = max(maxVal, a[j*n + i]);
	return maxVal;
}

int main()
{
	clock_t t1;
	clock_t t;

	// Set size of the matrix
	int n = 10;

	// Create CPU Array
	float* matrix = new float[n*n];
	InitMatrix(matrix, n, n);
	cout << "Created a " << n << " x " << n << " Matrix." << endl;

	float maxVal = FindMaxCPU(matrix, n, n);
	cout << "Maximum value from CPU computation is : " << maxVal << endl;
	t1 = clock() - t1;
	printf("It took me %d clicks (%f seconds).\n",t1,((float)t1)/CLOCKS_PER_SEC);

	// Use the following code for print debugging
	//cout << endl;
	//PrintMatrix(matrix, n, n);
	//cout << endl;

	// Allocate GPU Memory
	float* matrix1CUDA;
	float* matrix2CUDA;
	cudaMalloc((void**)&(matrix1CUDA), n*n*sizeof(float));
	cudaMalloc((void**)&(matrix2CUDA), n*n*sizeof(float));
	cudaCheckError();

	// Copy GPU Memory
	cudaMemcpy(matrix1CUDA, matrix, n*n*sizeof(float), cudaMemcpyHostToDevice);
	cudaCheckError();

	// Setup swap of CUDA device pointers
	float* inputCUDA;
	float* outputCUDA;
	inputCUDA = (matrix1CUDA);
	outputCUDA = (matrix2CUDA);

	// Run the Kernel
	for (int p = n / 2; p >= 1; p = p / 2)
	{
		dim3 block(GetBlockSize(p, 2), GetBlockSize(p, 1), 1);
		dim3 grid(GetGridSize(p, block.x), GetGridSize(p, block.y), 1);
		FindMax4 << < grid, block >> >(inputCUDA, outputCUDA, p);
		cudaCheckError();
	
	
		cout<<p<<endl;
		
		// Use the following code for print debugging
#ifdef DEBUG
		//float* tempDataIn = new float[2 * p * 2 * p];
		//cudaMemcpy(tempDataIn, inputCUDA, 2 * p * 2 * p * sizeof(float), cudaMemcpyDeviceToHost);
		//cudaCheckError();
		//PrintMatrix(tempDataIn, 2*p, 2*p);
		//cout << endl;
		//delete[] tempDataIn;

		//float* tempDataOut = new float[p*p];
		//cudaMemcpy(tempDataOut, outputCUDA, p * p * sizeof(float), cudaMemcpyDeviceToHost);
		//cudaCheckError();
		//PrintMatrix(tempDataOut, p, p);
		//cout << endl;
		//delete[] tempDataOut;
#endif

		// Swap input output pointers
		float* oldInputCUDA = inputCUDA;
		inputCUDA = outputCUDA;
		outputCUDA = oldInputCUDA;

	}

	float maxValGPU;
	cudaMemcpy(&maxValGPU, inputCUDA, 1 * sizeof(float), cudaMemcpyDeviceToHost);
	cout << "Maximum value from GPU computation is : " << maxValGPU << endl;

	cudaDeviceSynchronize();
	cudaCheckError();

	// Free the Memory
	cudaFree(matrix1CUDA);
	cudaFree(matrix2CUDA);
#ifdef DEBUG
	cudaCheckError();
#endif
	t = clock() - t;
	printf("It took me %d clicks (%f seconds).\n",t,((float)t)/CLOCKS_PER_SEC);
	return 0;
}
