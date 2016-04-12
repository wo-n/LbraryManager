# coding: utf-8
library1 = Library.find(1).id
0.upto(4) do |idx|
  Notice.create({ title: "図書館調査#{idx}",
    body: "すごかったー",
    released_at: 8.days.ago.advance(days: idx),
    library_id: library1 },without_protection: true
  )
end

library2 = Library.find(2).id
5.upto(9) do |idx|
  Notice.create({ title: "図書館調査#{idx}",
    body: "すごかったー",
    released_at: 8.days.ago.advance(days: idx),
    library_id: library2 },without_protection: true
  )
end
