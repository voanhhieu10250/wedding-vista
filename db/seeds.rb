# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

[
  {
    title: "Lập kế hoạch",
    description: "Nhận trợ giúp lập kế hoạch đám cưới, ý tưởng mới và lời khuyên từ các thành viên Cộng đồng. Đặt câu hỏi về kế hoạch của bạn và chia sẻ các mẹo về mọi thứ, từ việc luôn cập nhật ngân sách cho đến những việc tiếp theo trong danh sách kiểm tra kế hoạch của bạn.",
    icon: "svg/planning.svg"
  },
  {
    title: "Trang phục cưới",
    description: "Hỏi tất cả các câu hỏi của bạn về váy cưới, bộ vest cưới, tuxedo, giày, mạng che mặt, phụ kiện, trang sức, v.v. Chúng tôi cũng sẽ giúp bạn tìm được vẻ ngoài hoàn hảo cho tiệc cưới của mình!",
    icon: "svg/attire.svg"
  },
  {
    title: "Tự làm",
    description: "Đã đến lúc thể hiện khả năng thủ công của bạn! Hãy lấy máy khâu ra, thành thạo nghệ thuật sử dụng súng bắn keo và cho Cricut thấy ai là ông chủ - phần này là về việc sáng tạo và tùy chỉnh đồ trang trí ngày cưới của bạn. Chia sẻ mẹo tự làm và tiến trình của bạn tại đây!",
    icon: "svg/wedding-cake.svg"
  },
  {
    title: "Phong cách và trang trí",
    description: "Chủ đề đám cưới, màu sắc đám cưới, trang trí đám cưới và hơn thế nữa! Từ hoa, rèm và bảng hiệu tùy chỉnh - có rất nhiều lựa chọn để bạn lựa chọn. Gửi câu hỏi, nguồn cảm hứng và phản hồi của bạn ở đây.",
    icon: "svg/decor.svg"
  }, {
    title: "Tiệc cưới",
    description: "Hãy bắt đầu bữa tiệc thôi! Nhận trợ giúp để chọn đúng loại nhạc, chỗ ngồi cho khách, chọn thực đơn, món ăn chính, bánh ngọt, bánh mì nướng, quà cưới và mọi thứ khác liên quan đến lễ tân.",
    icon: "svg/reception.svg"
  },
  {
    title: "Lễ cưới và nghi thức",
    description: "Từ nghi lễ rước dâu đến nghi lễ rước dâu - và mọi thứ ở giữa - đây là không gian để bạn có được câu trả lời cho mọi thứ bạn từng thắc mắc về lời thề, nghi lễ hợp nhất, người chủ trì, truyền thống, v.v. Sau cùng, lễ cưới chính là tất cả những gì liên quan đến sự kiện này, đúng không?!",
    icon: "svg/camera.svg"
  },
  {
    title: "Cuộc sống hôn nhân",
    description: "Xin chúc mừng các cặp đôi mới cưới và đã kết hôn! Đừng quên, có thể vẫn còn những lời cảm ơn, giấy tờ đổi tên và album ảnh trong tương lai của bạn.",
    icon: "svg/love-letter.svg"
  },
  {
    title: "Gia đình và các mối quan hệ",
    description: "Việc hòa nhập các gia đình có thể là niềm vui thực sự, nhưng cũng có những yếu tố khó khăn. Từ việc hợp nhất các hộ gia đình đến quyết định nơi dành kỳ nghỉ, đây là nơi để trao tặng và nhận được sự hỗ trợ về mọi thứ liên quan đến gia đình.",
    icon: "svg/gift.svg"
  },
  {
    title: "Tuần trăng mật",
    description: "Lên kế hoạch cho chuyến đi nghỉ sau đám cưới của bạn? Nhận câu trả lời cho các câu hỏi về tuần trăng mật, mẹo và gợi ý đóng gói. Từ những điểm đến tốt nhất, đến mức giá thấp nhất, đến thời điểm bạn nên thực hiện chuyến đi của mình - hãy nói tất cả ở đây!",
    icon: "svg/big-car.svg"
  },
  {
    title: "Sự kiện",
    description: "Bạn đang lên kế hoạch tổ chức các sự kiện để ăn mừng cùng bạn bè và gia đình trước ngày trọng đại? Chia sẻ ảnh và cho chúng tôi biết tất cả về bữa tiệc đính hôn, lễ tắm và các bữa tiệc độc thân hoặc cử nhân của bạn!",
    icon: "svg/party.svg"
  },
  {
    title: "Tóc và trang điểm",
    description: "Chia sẻ cảm hứng làm tóc và trang điểm cưới của bạn, nhận đề xuất về các nghệ sĩ trang điểm và làm tóc giỏi nhất, đồng thời nhận trợ giúp để chọn diện mạo phù hợp cho ngày cưới của bạn.",
    icon: "svg/makeup.svg"
  }
].each do |f|
  Forum.find_or_create_by!(f)
end

[
  {
    name: "Planning Basics",
    description: "While your engagement is sure to be a fun and exciting time, there’s some work involved, too. We’re here to help make the wedding planning process as stress-free as possible, and provide loads of helpful advice. Whether you’re setting your budget, choosing a venue, or learning about the latest wedding trends, you’ll find everything you need to know about wedding planning right here."
  },
  {
    name: "Wedding Ceremony",
    description: "The wedding ceremony is your big moment, and deserves just as much careful attention as the rest of your celebration. After all, saying “I do” is what makes you married! From writing your vows to choosing the perfect officiant, we’ve got the advice and insight you need to make your ceremony truly memorable."
  },
  {
    name: "Wedding Reception",
    description: "Let’s get the party started! It’s time to celebrate with the people you love most, and we’re here to help you choose the best venue, pick a perfect menu, and fine-tune the timeline so your wedding reception is totally seamless – and totally unforgettable. Raise a glass to the newlyweds!"
  },
  {
    name: "Wedding Services",
    description: "Your wedding vendors are the creative partners who bring all of those carefully planned details to life. Here’s how to find the best vendors for your wedding style and budget, and to make the most of their all-important services so your wedding day is an absolute dream."
  },
  {
    name: "Wedding Fashion",
    description: "Look like a million bucks on your big day with the newest collections from top wedding dress designers, the latest trends in suits and tuxedos, the most stylish accessories, and bridesmaids’ looks your ladies will love. Don’t be surprised if the aisle feels more like a runway on your wedding day!"
  },
  {
    name: "Hair & Makeup",
    description: "Be the best version of yourself on your wedding day. From hair and makeup inspiration and tips to get you and your wedding party totally glam, to health and fitness routines that will have you looking and feeling totally incredible, we’ve got the best insight for all shapes, sizes, and styles."
  },
  {
    name: "Destination Weddings",
    description: "Get out of town! If you’re hosting a destination wedding, whether it’s 100 or 1,000 miles from home, there are a lot of details to keep track of. From budgeting properly to keeping your guests informed to choosing the perfect dress for your venue, we’re here to help you through the journey so you can enjoy the destination."
  },
  {
    name: "Married Life",
    description: "Your wedding may be over, but your lives together are just beginning. Your married friends are right - things will feel different when you wake up for the first time as a married couple. It’s an exciting time, and we’re here to help make this new phase in your life a fantastic one with tips, tricks, and advice to set you up for success."
  },
  {
    name: "Events & Parties",
    description: "Your wedding day is the main event, but don't forget the build-up! There are a number of pre- and post-wedding parties that need your attention, from organizing the engagement party to planning the perfect bachelorette bash. Whatever soirée you’ve got on the calendar, we’ve got your back."
  },
  {
    name: "Family & Friends",
    description: "There’s nothing like that feeling of having everyone you love in one place to celebrate such a happy occasion. Here’s everything you need to know about the people who make your wedding day special, from your bridesmaids and groomsmen to the family and friends who will be surrounding the altar and filling the dance floor."
  }
].each do |f|
  TopicCategory.find_or_create_by!(f)
end
