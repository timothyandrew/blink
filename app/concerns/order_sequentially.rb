module OrderSequentially
  extend ActiveSupport::Concern

  class_methods do
    # Take a list of records, and a sequenced list of record_ids.
    # Change the `position` of each record based on the position of their
    # id in `sequence`.
    def order_sequentially!(records, sequence)
      transaction do
        records.each do |record, i|
          position = sequence.index(record.id.to_s) || 0
          record.position = position
          record.save!
        end
      end
    end
  end
end
