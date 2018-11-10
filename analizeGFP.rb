require 'numo/narray'
include Numo
require 'csv'

def load_data(path)
    # Loading Datas
    datas = CSV.read('./gfp.csv', headers:false)[2..-1]
    # 
    datas.each_index{|row|
        datas[row].each_index{|col|
            datas[row][col] = datas[row][col].to_f
    }
}
    return datas
end

def arange_datas(datas)
    
end

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



