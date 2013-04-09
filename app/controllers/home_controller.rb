require 'point_solver'
class HomeController < ApplicationController
  
  def index
  end

  def solve
    points = params[:points].map{|k1,v1| v1.map{|k2,v2| v2.to_f }}
    solver = PointSolver.new(points)

    if solver.colinear?
      colinear = true
      messages = ['Points are colinear.']
    else
      p5 = solver.symmetric_point
      plane = solver.plane_equation
      messages = [
        'Points are not colinear',
        "Equation for plane: #{plane}",
        "Point symmetrical to point 4 about the plane: #{p5}" 
      ]
    end

    render json: { colinear: colinear, symmetric_point: p5, messages: messages }
  end

end