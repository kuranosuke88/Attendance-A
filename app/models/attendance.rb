class Attendance < ApplicationRecord
  FLAG_FIELDS = [:overtime]
  belongs_to :user
  
  validates :worked_on, presence: true
  validates :note, length: { maximum: 50 }
  
  # 出勤時間が存在しない場合は退勤時間は無効
  validate :finished_at_is_invalid_without_a_started_at
  # 出勤、退勤時間どちらも存在し、出勤時間より早い退勤時間は無効
  validate :started_at_than_finished_at_fast_if_invalid
  
  def finished_at_is_invalid_without_a_started_at
    errors.add(:started_at, "が必要です。") if started_at.blank? && finished_at.present?
  end
  
  def started_at_than_finished_at_fast_if_invalid
    if started_at.present? && finished_at.present?
      errors.add(:started_at, "より早い退勤時間は無効です。") if started_at > finished_at
    end
  end
  
  def true_flags
    ret = []
    FLAG_FIELDS.each do |flag_name|
      if self[flag_name]
        ret << flag_name
      end
    end
    ret
  end
  
  def i18n_true_flags
    true_flags.map{ |flag_name| Attendance.human_attribute_name(flag_name) }
  end
  
end
