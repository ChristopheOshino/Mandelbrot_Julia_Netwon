# Mandelbrot_Julia_Netwon
Codes for the course project, MATH 507, Dynamical System, FA2024. Topic on Visualization of Mandelbrot set and Julia set, Newton iteration on complex plane.

# Code Instructions
Programming language: Julia
Package: GLMakie

# Mandelbrot.jl
Interactive visualization of Mandelbrot set. click on the left figure to select parameter c and to show first few iterates of the orbit of 0 under the complex polynomial function P_c(z) = z^2 + c. For every c chosen, right figure is the corresponding Julia set. Moving mouse to see orbits of the point at your mouse position.

# Newton_qubic.jl
Create pixel based figure of the parameter space of the newton interations of qubic polynomial f(z) = (z-1)(z+1)(z-\lambda) with parameter \lambda.

To zoom in or out, change the x,y range in the code and change the precision.
