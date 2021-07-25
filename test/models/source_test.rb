# == Schema Information
#
# Table name: sources
#
#  id            :bigint           not null, primary key
#  desc          :string
#  intent        :jsonb
#  last_used_at  :datetime
#  name          :string
#  private       :boolean
#  schema        :jsonb
#  source_type   :string
#  state         :jsonb
#  type          :string
#  url           :string
#  webhook_token :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  pipeline_id   :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_sources_on_pipeline_id  (pipeline_id)
#  index_sources_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (pipeline_id => pipelines.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class SourceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
