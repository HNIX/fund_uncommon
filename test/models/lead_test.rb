# == Schema Information
#
# Table name: leads
#
#  id                 :bigint           not null, primary key
#  address            :string
#  address2           :string
#  address_state      :string
#  city               :string
#  email              :string
#  first_name         :string
#  last_name          :string
#  marketing_accepted :boolean
#  phone              :string
#  zip_code           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  account_id         :bigint           not null
#  source_id          :bigint           not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_leads_on_account_id  (account_id)
#  index_leads_on_source_id   (source_id)
#  index_leads_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (source_id => sources.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class LeadTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
