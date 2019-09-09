class Person < ApplicationRecord
  has_one :personal_info, dependent: :destroy
  has_many :my_jobs, class_name: 'Job', dependent: :destroy
  has_and_belongs_to_many :hobbies
  has_many :jobs, dependent: :destroy
  has_many :approximate_salaries, through: :jobs, source: :salary_range

  def max_salary
    approximate_salaries.maximum(:max_salary)
  end

  scope :by_age_desc, -> { order age: :desc }
  scope :starts_with, -> (search_string) { where('first_name LIKE ?', "#{search_string}%") }
end


