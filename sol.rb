#!/usr/bin/env ruby
#

class Vec3
  include Math

  attr_reader :x,:y,:z

  def initialize(x, y, z)
    @x = x.to_f
    @y = y.to_f
    @z = z.to_f
  end

  def length
    sqrt(x*x+y*y+z*z)
  end

  def normalize!
    l = length
    @x, @y, @z = @x/l, @y/l, @z/l
    self
  end

  def normalize
    dup.normalize!
  end

  # Dot product, it returns the cos of the angle between the vectors
  # It is the length of the projection of one vector onto the other.
  def dot(a)
    @x*a.x + @y*a.y + @z*a.z
  end

  # Angle between the vectors
  def angle(a)
    acos(dot(a))
  end

  # Given 2 vectors, what is the overlape relative to the 2 vectors
  def effect(a)
    normalize.dot(a.normalize)
  end

  # If the vectors are the ground and the sun, what is the 'power' relative to 1.
  def shine(a)
    1.0 - effect(a)
  end

  def cross(a)
  puts to_s
  puts a.to_s
    self.class.new(
        @y*a.z - @z*a.y,
        @z*a.x - @x*a.z,
        @x*a.y - @y*a.x)
  end

  # Normal vector to a place (defined by 2 vector
  def self.normal(a,b)
    a.cross(b)
  end

  def to_s
    "[%1.4f %1.4f %1.4f]" % [@x,@y,@z]
  end
end

u = Vec3.new(1,1,0)
v = Vec3.new(0,1,0)

puts u.cross(v)
exit


u = Vec3.new(1,0,0)
v = Vec3.new(1,Math::sqrt(3),0).normalize

puts "Affect = #{u.effect(v)}"
puts u.angle(v)/Math::PI*180
puts v.angle(u)/Math::PI*180

v = Vec3.new(Math::sqrt(3),1,0).normalize
puts "Affect = #{u.effect(v)}"
puts u.angle(v)/Math::PI*180
puts v.angle(u)/Math::PI*180

puts Math::cos(Math::PI/4 - v.angle(u))

(0..100).each do |y|
  puts "shine #{y} => #{u.shine(Vec3.new(1,y,0))}"
end


