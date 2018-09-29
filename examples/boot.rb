#!/usr/bin/env ruby
infile = ARGV[0] 
outfile = ARGV[1]
start = ARGV[2]
finish = ARGV[3]
puts("#{start} - #{finish}");
#bfc00000: 100000ff 00000000 100000fd 00000000    ................
f = File.new(infile, "r")
fout = File.new(outfile, "w")
writeFlag = false
while(line = f.gets)
 splitLine = line.strip.split(/\s+/, 6)
 if(splitLine.size == 6)
  address=splitLine[0]
  address=address[0,8]
  hex1=splitLine[1]
  hex2=splitLine[2]
  hex3=splitLine[3]
  hex4=splitLine[4]
  ascii=splitLine[5]
  str = "#{address} #{hex1}#{hex2}#{hex3}#{hex4} #{ascii}"
  if(address.downcase == start.downcase)
   puts("Found start: #{str}")
   writeFlag = true;
  end
 if(writeFlag == true)
   unhex1=[hex1].pack("H*").reverse
   unhex2=[hex2].pack("H*").reverse
   unhex3=[hex3].pack("H*").reverse
   unhex4=[hex4].pack("H*").reverse
   unhex = unhex1 + unhex2 + unhex3 + unhex4
   fout.write(unhex)
  end
  if(address.downcase == finish.downcase)
   puts("Found finish: #{str}")
   fout.close();
   exit
  end
 end
end
f.close()
