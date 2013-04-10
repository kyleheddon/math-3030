require 'point_solver'
class HomeController < ApplicationController
  
  def index
  end

  def solve
    points = points_from_params
    solver = PointSolver.new(points)

    if solver.colinear?
      colinear = true
      messages = ['Points are colinear.']
    else
      p5 = solver.symmetric_point
      plane_equation = solver.plane_equation
      messages = [
        'Points are not colinear',
        "Equation for plane: <b>#{ plane_equation }</b>",
        "Point symmetrical to point 4 about the plane: <b>#{ p5.collect{|s| s.round(3)} }</b>" 
      ]
    end

    render json: { colinear: colinear, symmetric_point: p5, messages: messages }
  end

  private

  def points_from_params
    params[:points].map do |point_index, point_coordinates| #In -> {  0: { 0: '5.1', 1: '6', 2: '3' }, {...}, {...}  }
      point_coordinates.map{|coordinate, value| value.to_f } 
    end #Out ->  [  [5.1, 6, 3], [...], [...]  ]
  end

end