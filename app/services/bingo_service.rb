require 'rubygems'
require 'RMagick'

class BingoService
  include Magick
  include ActiveModel::Validations

  class Coordinate
    attr_accessor :x, :y

    def initialize(x,y)
      self.x = x
      self.y = y
    end
  end

  attr_reader :words

  validates_each :words do |record, attr, value|
    record.errors.add(attr, "not enough words") if value.size < 25
  end

  def initialize(words = nil)
    @words = words || %w(blind blend bless black blow blood bleed blaze blink blue blur block clam
                         clap clash clip class claw clay clean clear climb click clock close cloth cloud clot clownclue
                         plant plan play planet plug plus please plot pluck plow plate plane place slab slack slam
                         slag slap slant slate sleep slice slide sling slip slit slope slow slush)
  end

  def generate
    text = Draw.new
    text.font_family = "Helvetica"
    text.fill = "black"
    text.stroke = "transparent"
    text.gravity = CenterGravity
    text.align = CenterAlign
    text.pointsize = 85

    coordinates = []

    xs = [256, 545, 836, 1120, 1408]
    ys = [830, 1108, 1400, 1680, 1974]

    xs.each do |x|
      ys.each do |y|
        coordinates << Coordinate.new(x, y)
      end
    end

    words = @words.shuffle.first(25)

    5.times.map do
      image = Image.read(Rails.root + "app/assets/images/bingo.png").first

      words.shuffle!

      coordinates.each_with_index do |coordinate, i|
        text.annotate(image, 150, 150, coordinate.x, coordinate.y, words[i])
      end

      image.to_blob
    end
  end
end
