class Sample < ApplicationRecord
  enum decision: { "なし" => 1, "申請中" => 2, "承認" => 3, "否認" => 4 }
end
