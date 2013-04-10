class PointSolver
  attr_accessor :points, :normal_vector, :plane_equation

  def initialize points
    self.points = points

    p1p2 = get_vector(points[0], points[1])
    p2p3 = get_vector(points[1], points[2])
    self.normal_vector = get_cross_product(p1p2, p2p3)
  end

  def colinear?
    norm(normal_vector) == 0
  end

  def symmetric_point
    p1 = points[0]
    p4 = points[3]
    plane = get_plane(p1)
    self.plane_equation = "#{plane[0]}x + #{plane[1]}y + #{plane[2]}z + #{plane[3]} = 0"

    find_symmetrical_point(plane, p4)
  end

  private

  def get_vector p1, p2
    [p2[0] - p1[0], p2[1] - p1[1], p2[2] - p1[2]]
  end

  def get_cross_product a, b
    [ 
      det(a[1], a[2], b[1], b[2]),
      det(a[0], a[2], b[0], b[2]) * (-1), 
      det(a[0], a[1], b[0], b[1]) 
    ]
  end

  def det a1, a2, b1, b2
    #  |a1 a2|
    #  |b1 b2|

    a1*b2 - a2*b1
  end

  def norm v 
    Math.sqrt(v[0]**2 + v[1]**2 + v[2]**2)
  end

  def get_plane p
    v = normal_vector
    plane = [ 
      v[0], 
      v[1], 
      v[2], 
      - (v[0]*p[0] + v[1]*p[1] + v[2]*p[2])
    ]
  end

  def find_symmetrical_point plane, p
    distance = signed_distance(plane, p)
    unit_vector = get_unit_vector

    # -2d*u + p
    add_arrays( 
      multiply_scalar_and_array( -2*distance , unit_vector ), 
      p
    ) 
  end

  def signed_distance pl, p
    q = pl[0]*p[0] + pl[1]*p[1] + pl[2]*p[2] + pl[3]
    puts "point is on the #{ q == q.abs ? 'same' : 'opposite' } side of the normal vector"
    q / norm(normal_vector)
  end

  def get_unit_vector 
    v = normal_vector
    vr = []
    v.each do |vi|
      vr << vi/norm(v)
    end
    vr
  end

  def multiply_scalar_and_array s, a
    as = []
    a.each do |ai|
      as << ai*s
    end
    as
  end

  def add_arrays a1, a2
    ar = []
    a1.each_with_index do |ai, i|
      ar << (a1[i] + a2[i]) 
    end
    ar
  end


end