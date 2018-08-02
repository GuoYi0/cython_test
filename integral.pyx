import numpy as np
cimport numpy as np
cimport cython


cdef extern from "math.h":
    float powf(float x, float y)


@cython.boundscheck(False)
@cython.wraparound(False)
cdef np.ndarray[np.float32_t, ndim=2] _integration(np.ndarray[np.int32_t, ndim=1] pixel, int h, int w, int gamma=2, int k=10):
    cdef int length=h*w,i,j, dx, dy, i_x, j_x, i_y, j_y
    cdef float distance, fenmu, tempx, tempy
    cdef np.ndarray[np.float32_t, ndim = 2] xy = np.zeros([2, length], dtype=np.float32)
    for i in range(length-1):
        i_x = i%w
        i_y = i // w
        for j in range(i+1, length):
            j_x = j%w
            j_y = j // w
            if pixel[i]==0 and pixel[j]==0:
                continue
            dx = j_x - i_x
            dy = j_y - i_y
            fenmu = float(dx*dx + dy*dy)
            fenmu = powf(fenmu, 0.5*(gamma+1))
            tempx = k*dx / fenmu
            tempy = k*dy / fenmu
            if pixel[j] == 1:
                xy[0, i] += tempx
                xy[1, i] += tempy
            elif pixel[j] == -1:
                xy[0, i] += 0.5*tempx
                xy[1, i] += 0.5*tempy
            if pixel[i] == 1:
                xy[0, j] += -tempx
                xy[1, j] += -tempy
            elif pixel[i] == -1:
                xy[0, j] += -0.5*tempx
                xy[1, j] += -0.5*tempy
    return xy

def integration(np.ndarray[np.int32_t, ndim=1] pixel, int h, int w, int gamma=2, int k=10):
    return _integration(pixel, h, w, gamma, k)

