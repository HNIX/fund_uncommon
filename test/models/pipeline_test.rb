# == Schema Information
#
# Table name: pipelines
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_pipelines_on_account_id  (account_id)
#  index_pipelines_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class PipelineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
