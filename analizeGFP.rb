require 'numo/narray'
include Numo
require "numo/gnuplot"
require 'csv'

def load_data(path)
    # loading Datas
    datas = CSV.read('./gfp.csv', headers:false)[2..-1]
    # converting string to float
    datas.each_index{|row|
        datas[row].each_index{|col|
            datas[row][col] = datas[row][col].to_f
        }
    }
    # return data as Numo::NArray
    return DFloat[*datas]
end

def arrange_datas(datas)
    # setting vertical value
    cycles = datas[0..-1, 0]
    # setting holizonal value
    gfp  = datas[0..-1, 1..-1]
    gfp -= gfp[0, 0..-1]
    gfp  = gfp.transpose(1, 0)

    # calculateing mean & std
    means = []
    stds  = []
    for i in 0...gfp.shape[0]/3 do
        means << gfp[3*i...3*(i+1), true].mean(0)
        stds << gfp[3*i...3*(i+1), true].stddev(0)
    end
    return cycles, DFloat[*means], DFloat[*stds], gfp
end

cycles, means, stds, gfp = arrange_datas(load_data('./gfp.csv'))

Label = ("0"..."6").to_a

dataset = []
for i in 0...means.shape[0] do
    dataset << [cycles, means[i, true], w:"linespoints", pt: 6, lw: 2, t:Label[i]]
end

Numo.gnuplot do
  set title: "X-Y data plot"

  set xlabel: "Cycle [10 min/cycle]"
  set xrange: 1..25

  set ylabel: "GFP Fluorescence Intensity [a.u.]"

  plot *dataset
end



