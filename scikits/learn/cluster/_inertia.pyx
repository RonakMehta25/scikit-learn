import numpy as np
cimport numpy as np
cimport cython
ctypedef np.float64_t DOUBLE
ctypedef np.int_t INT


@cython.boundscheck(False)
@cython.wraparound(False)
@cython.cdivision(True)
def compute_inertia(np.ndarray[DOUBLE, ndim=1] m_1,\
                    np.ndarray[DOUBLE, ndim=2] m_2,\
                    np.ndarray[DOUBLE, ndim=2] m_3,\
                    np.ndarray[INT, ndim=1] coord_row, 
                    np.ndarray[INT, ndim=1] coord_col,\
                    np.ndarray[DOUBLE, ndim=1] res):
    cdef int size_max = coord_row.shape[0]
    cdef int n_features = m_3.shape[1]
    cdef int i, j, row, col
    cdef DOUBLE pa, n
    for i in range(size_max):
        row = coord_row[i]
        col = coord_col[i]
        n = m_1[row] + m_1[col]
        pa = 0.
        for j in range(n_features):
            pa += m_3[row, j] + m_3[col, j]
            pa -= ((m_2[row, j] + m_2[col, j])**2) / n
        res[i] = pa
    return res
