#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

#define MAX_SIZE 1000000

void merge(int arr[], int left[], int left_size, int right[], int right_size)
{
    int i, j, k;

    i = 0;
    j = 0;
    k = 0;

    while (i < left_size && j < right_size)
    {
        if (left[i] < right[j])
        {
            arr[k++] = left[i++];
        }
        else
        {
            arr[k++] = right[j++];
        }
    }

    while (i < left_size)
    {
        arr[k++] = left[i++];
    }

    while (j < right_size)
    {
        arr[k++] = right[j++];
    }
}

void merge_sort(int arr[], int size)
{
    int i, mid, *left, *right;

    if (size < 2)
    {
        return;
    }

    mid = size / 2;

    left = (int *)malloc(mid * sizeof(int));
    right = (int *)malloc((size - mid) * sizeof(int));

    for (i = 0; i < mid; i++)
    {
        left[i] = arr[i];
    }

    for (i = mid; i < size; i++)
    {
        right[i - mid] = arr[i];
    }

    #pragma omp parallel sections
    {
        #pragma omp section
        {
            merge_sort(left, mid);
        }
        #pragma omp section
        {
            merge_sort(right, size - mid);
        }
    }

    merge(arr, left, mid, right, size - mid);

    free(left);
    free(right);
}

int main()
{
    int arr[MAX_SIZE];
    int i, size;

    printf("Enter the size of the array: ");
    scanf("%d", &size);

    if (size > MAX_SIZE)
    {
        printf("Size is too large.\n");
        return -1;
    }

    printf("Enter the elements of the array:\n");

    for (i = 0; i < size; i++)
    {
        scanf("%d", &arr[i]);
    }

    merge_sort(arr, size);

    printf("Sorted array:\n");

    for (i = 0; i < size; i++)
    {
        printf("%d ", arr[i]);
    }

    printf("\n");

    return 0;
}
