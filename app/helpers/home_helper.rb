module HomeHelper
  def index coordinate
    case coordinate
    when 'x'
      0
    when 'y'
      1
    when 'z'
      2
    end
  end
end