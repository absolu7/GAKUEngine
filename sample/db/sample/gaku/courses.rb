# encoding: utf-8

codes = [ "Spring2012", "Fall2012", "Spring2013", "Fall2013"]

codes.each do |code|
  Gaku::Course.create(:code => code)
end