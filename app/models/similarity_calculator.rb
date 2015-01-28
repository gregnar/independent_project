class SimilarityCalculator
  attr_reader :comparisons

  def initialize(comparisons)
    @comparisons = comparisons
  end

  def calculate_similarity
    return if filtered_comps.empty?
    decimal.round
  end

  def filtered_comps
    @filtered_comps ||= filter_comparisons
  end

  def filter_comparisons
    comparisons.reject{ |comp| comp['your_review']['rating'].to_i.zero? }
               .reject{ |comp| comp['their_review']['rating'].to_i.zero? }
  end

  def decimal
    (number_similar / filtered_comps.count.to_f) * 100
  end

  def number_similar
    filtered_comps.inject(0) do |sum, comp|
      sum += 1 if (yours(comp) - theirs(comp)).abs <= 1; sum
    end
  end

  def yours(comp)
    comp['your_review']['rating'].to_i
  end

  def theirs(comp)
    comp['their_review']['rating'].to_i
  end

end
