require 'numo/narray'
include Numo
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
    p gfp

    # calculateing mean & std
    index = DFloat.new(gfp.shape[0]/3, 3).seq
    means = []
    stds  = []
    for i in 0...index.shape[0] do
        means << gfp[true, 3*i...3*(i+1)].mean(1)
        stds << gfp[true, 3*i...3*(i+1)].stddev(1)
    end
end

arrange_datas(load_data('./gfp.csv'))

exit!

z = DFloat[*datas]
cycles = z[0..-1, 0]
gfp    = z[0..-1, 1..-1]
gfp   -= gfp[0, 0..-1]
gfp    = gfp.transpose(1, 0)

index = [] << [0, 0..-1] 
p index
p gfp[0...3, 0..-1].mean(0)

means = gfp

index = DFloat.new(18).seq().reshape(6, 3)



