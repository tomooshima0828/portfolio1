class Event < ApplicationRecord
  belongs_to :user

  def start_time
    self.started_at
  end

  def end_time
    self.finished_at
  end
end
