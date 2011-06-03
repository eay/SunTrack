#!/usr/bin/env ruby
#

# http://www.math.niu.edu/~rusin/uses-math/position.sun/solar.position
class Sun
  include Math

  Location = { "Brisbane" => [
    -27.0 - 29.0/60, # latitude
    153.0 +  8.0/60] # longitude
  }

  def latitude_of(where)
    Location[where][0] || raise("unknown location")
  end

  # Vernal equinox, Spring equinox in Soutern half of the world
  # Taken from http://en.wikipedia.org/wiki/Equinox
  Equinox = {
    2010 => Time.utc(2010,03,20,17,32),
    2011 => Time.utc(2011,03,20,23,21),
    2012 => Time.utc(2011,03,20,05,14),
    2013 => Time.utc(2011,03,20,11,02),
    2014 => Time.utc(2011,03,20,16,57),
    2015 => Time.utc(2011,03,20,22,45),
    2016 => Time.utc(2011,03,20,04,30),
    2017 => Time.utc(2011,03,20,10,28),
  }

  def initialize(where = "Brisbane",yday = Time.new)

    yday = yday.yday if Time === yday
    @latitude = latitude_of where
    @yday = yday

    # Solar declination
    @declination = solar_declination(@yday)

  end

  def to_degrees(r)
    r/PI*180
  end

  def to_radians(d)
    d/180.0*PI
  end

  def to_hms(h)
    m = (h - (h.to_i))*60
    s = (m - (m % 60))*60
    "%02dh%02dm%02ds" % [h.to_i, m.to_i, s.to_i]
  end

  def length_of_day(yday = @yday)
    yday = yday if Time === yday
    d = solar_declination(yday)
    puts "d= #{d}"
    puts "l= #{@latitude}"
    to_degrees(2*acos(-tan(to_radians d)*tan(to_radians @latitude)))/15.0
  end

  # The number of days that have passed since the sun was over
  # the spring (southern hemisphere) equator
#  def days_since_equinox(time = Time.now)
#    year0 = Equinox[time.year  ] || Time.utc(time.year  ,03,20,12,00)
#    year1 = Equinox[time.year-1] || Time.utc(time.year-1,03,20,12,00)
#    eq = (year0 <= time) ? year0 : year1
#    (time - eq)/(24*60*60)
#  end

  # The angle of the Sun relative to the equator
  def solar_declination(yday = @yday)
    yday = time.yday if Time === yday 
    23.45*cos(2*PI*(yday-172)/365)
  end

  def do_it(where,yday)
    yday == time.yday if Time === yday
    # Solar declination
    d = solar_declination(yday)
    puts d.class
    # Hour angle
    h = (-tan(d)*tan(l)) % (PI/4)
    puts h
#    h = (acos(h)/PI)*180
    # Solar altitude - degrees above the horizon
#    a =
    length of day
    [d,l,h]
  end
end


s = Sun.new("Brisbane")
puts "length of day = #{s.length_of_day} #{s.to_hms s.length_of_day}"

#puts "days since equinox = #{s.days_since_equinox}"
#puts 

#0.upto(365) do |d|
#  d,l,h = do_it("Brisbane", d)
#  puts "d = #{d} l = #{l} h = #{h}"
#end
