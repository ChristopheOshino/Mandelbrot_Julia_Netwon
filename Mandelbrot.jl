## This is a interactive plot for Mandelbrot and filled Julia set
## It uses Escape Time Algorithm
## It also provides the iterates of 0 under z^2 + c depending on camera

using GLMakie
GLMakie.activate!() # hide

f = Figure(size = (1200,600))
ax = Axis(f[1,1])
ax2 = Axis(f[1,2])
yd = -2
yt = 2
xl = -2
xr = 2
ylims!(ax,yd,yt)
xlims!(ax,xl,xr)
X = -2:0.005:2
Y = -2:0.005:2
ylims!(ax2,-2,2)
xlims!(ax2,-2,2)
function mandelbrot(x, y)
    z = c = x + y*im
    for i in 1:20.0
        abs(z) > 2 && return i
        z = z^2 + c
    end 
    0
end

function filled_julia(x, y, p)
    c = p[1][1] + p[1][2] * im
    z = x + y * im
    for i in 1:100.0
        abs(z) > 1/2 + sqrt(1/4 + abs(c)) && return i
        z = z^2 + c
    end 
    0
end

Makie.deactivate_interaction!(ax, :rectanglezoom)
Makie.deactivate_interaction!(ax2, :rectanglezoom)
n = 30 ## length of iterates
point = Observable([Point2f(0,0)])
iterates = Observable([Point2f(0,0) for i = 1:n])
iter_julia = Observable([Point2f(0,0) for i = 1:n])
Z = Observable([0 for x in X, y in Y])

heatmap!(ax, xl:0.001:xr, yd:0.001:yt, mandelbrot, colormap = Reverse(:deep))
heatmap!(ax2, X, Y, Z, colormap = Reverse(:deep))
arc!(ax,Point2f(0),1,-pi,pi, color = :white)
lines!(ax,iterates,color = :white)
lines!(ax2,iter_julia,color = :white)
scatter!(ax2,iter_julia,color = :red)
scatter!(ax,point,color = :red)

# Define iterative function
function g(p,iter)
    y = iter[1][1] + iter[1][2]im
    c = p[1][1] + p[1][2]im
    for i = 2:n
        y = y^2 + c
        v = [y.re,y.im]
        iter[i] = v
    end
    return iter
end

on(events(ax).mousebutton) do event
    if event.button == Mouse.left
        point[] = [mouseposition(ax.scene)]
        iterates[] = g(point[],iterates[])
        Z[] = [filled_julia(x,y,point[]) for x in X, y in Y]
        notify(point)
        notify(iterates)
        notify(Z)
        ax.title = "The value of c is " * string(point[][1][1] + point[][1][2]*im) 
    end
end

on(events(ax2).mouseposition) do p
    iter_julia[][1] = mouseposition(ax2.scene)
    iter_julia[] = g(point[],iter_julia[])
    notify(point_julia)
    notify(iter_julia)
    ax2.title = "The value of initial point is " * string(iter_julia[][1][1] + iter_julia[][1][2]*im)
    sleep(0.005)
end

f