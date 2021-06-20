#include <stdlib.h>

size_t length(const char *s)
{
    size_t i = 0;
    while (*s)
    {
        ++i;
        ++s;
    }
    return i;
}

int max(const size_t n, const int *a)
{
    int m;
    size_t i;

    if (n == 0)
    {
        return 0;
    }

    m = a[0];
    for (i = 1; i < n; ++i)
    {
        if (a[i] > m)
        {
            m = a[i];
        }
    }

    return m;
}

int *merge_sort(int *up, int *down, unsigned int left, unsigned int right)
{
    if (left == right)
    {
        down[left] = up[left];
        return down;
    }

    unsigned int middle = (left + right) / 2;

    int *l_buff = merge_sort(up, down, left, middle);
    int *r_buff = merge_sort(up, down, middle + 1, right);

    int *target = l_buff == up ? down : up;

    unsigned int l_cur = left, r_cur = middle + 1;
    for (unsigned int i = left; i <= right; i++)
    {
        if (l_cur <= middle && r_cur <= right)
        {
            if (l_buff[l_cur] < r_buff[r_cur])
            {
                target[i] = l_buff[l_cur];
                l_cur++;
            }
            else
            {
                target[i] = r_buff[r_cur];
                r_cur++;
            }
        }
        else if (l_cur <= middle)
        {
            target[i] = l_buff[l_cur];
            l_cur++;
        }
        else
        {
            target[i] = r_buff[r_cur];
            r_cur++;
        }
    }
    return target;
}

int hsortmin(const size_t n, int *up)
{
    int *down = (int *)malloc(sizeof(int));
    int *res = merge_sort(up, down, 0, n - 1);
    return res[0];
}
