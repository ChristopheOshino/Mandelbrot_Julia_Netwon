using GLMakie

f = Figure(size = (800,800))
ax = Axis(f[1,1])
hidexdecorations!(ax, grid = false)
yd = 0.77
yt = 0.87
xl = 0.77
xr = 0.87
ylims!(ax,yd,yt)
xlims!(ax,xl,xr)
h = 10^(-4)
H = h
X = xl:h:xr
Y = yd:h:yt
function color_roots(x,y)
    lambda = x + y*im
    l = lambda/3
    N = 100
    for i = 1:N
        abs(1-l) < H && return 1
        abs(-1-l) < H && return -1
        abs(lambda - l) < H && return 2
        l = l - (l-1)*(l+1)*(l-lambda)/((l-1)*(l+1) + (l-1)*(l-lambda) + (l+1)*(l-lambda))
    end
    0
end

pl = heatmap!(ax,X,Y,color_roots,colormap=Makie.Categorical(:viridis))
Colorbar(f[1, 2], pl)

f