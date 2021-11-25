#cython: language_level=3

import numpy as np
cimport numpy as cnp

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

import cython

# Set the colormap
plt.rcParams['image.cmap'] = 'BrBG'

cdef evolve(cnp.ndarray[cnp.double_t, ndim=2] u, cnp.ndarray[cnp.double_t, ndim=2] u_previous, double a, double dt, double dx2, double dy2):
    """Explicit time evolution.
       u:            new temperature field
       u_previous:   previous field
       a:            diffusion constant
       dt:           time step. """

    # Getting rid of n, m variables and for loops. 
    # Slicing lists instead
    u[1:-1, 1:-1] = u_previous[1:-1, 1:-1] + a * dt * ( \
            (u_previous[2:, 1:-1] - 2*u_previous[1:-1, 1:-1] + \
             u_previous[:-2, 1:-1]) / dx2 + \
            (u_previous[1:-1, 2:] - 2*u_previous[1:-1, 1:-1] + \
                 u_previous[1:-1, :-2]) / dy2 )
    
    u_previous[:] = u[:]

@cython.boundscheck(False)
@cython.wraparound(False)
def iterate(cnp.ndarray[cnp.double_t, ndim=2] field, cnp.ndarray[cnp.double_t, ndim=2] field0, double a, double dx, double dy, int timesteps, int image_interval):
    """Run fixed number of time steps of heat equation"""

    cdef double dx2 = dx**2
    cdef double dy2 = dy**2

    # For stability, this is the largest interval possible
    # for the size of the time-step:
    cdef double dt = dx2*dy2 / ( 2*a*(dx2+dy2) )    

    for m in range(1, timesteps+1):
        evolve(field, field0, a, dt, dx2, dy2)
        if m % image_interval == 0:
            write_field(field, m)

@cython.boundscheck(False)
@cython.wraparound(False)
def init_fields(str filename):
    # Read the initial temperature field from file
    cdef cnp.ndarray[cnp.double_t, ndim=2] field = np.loadtxt(filename)
    cdef cnp.ndarray[cnp.double_t, ndim=2] field0 = field.copy() # Array for field of previous time step
    return field, field0

@cython.boundscheck(False)
@cython.wraparound(False)
def write_field(cnp.ndarray[cnp.double_t, ndim=2] field, int step):
    plt.gca().clear()
    plt.imshow(field)
    plt.axis('off')
    plt.savefig('heat_{0:03d}.png'.format(step))


