#!/usr/bin/env ruby
#

include Math

# Given an angle, what is the reduction in intensity of the sun due to
# less surface area.
def angle_effect(angle)
  t = tan(PI*angle/180)
  e = t / sqrt(t*t + 1)
end


5.step(90,5) do |angle|
  printf("angle = %2d, efficency = %0.2f\n",angle,angle_effect(angle));
end

puts "Brisbane, noon, summer => #{angle_effect(85)}"
puts "Brisbane, noon, winter => #{angle_effect(39)}"

[16,34,40,36].each do |angle|
  printf("angle = %2d, efficency = %0.2f\n",angle,angle_effect(angle));
end
puts

[38,64,83,73.5].each do |angle|
  printf("angle = %2d, efficency = %0.2f\n",angle,angle_effect(angle));
end
