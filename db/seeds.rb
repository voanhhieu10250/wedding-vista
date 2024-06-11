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

[
  { name: "Địa điểm tổ chức" },
  { name: "Chụp ảnh" },
  { name: "Dịch vụ ăn uống" },
  { name: "Trang phục" },
  { name: "Trang điểm & làm tóc" },
  { name: "Tổ chức đám cưới" },
  { name: "Hoa" },
  { name: "Quay phim" },
  { name: "Chủ hôn" },
  { name: "Ban nhạc" },
  { name: "Cho thuê" },
  { name: "Bánh cưới" },
  { name: "Trang trí & ánh sáng" },
  { name: "Du lịch" },
  { name: "Quà tặng" }
].each do |f|
  Category.find_or_create_by!(f)
end

[
  {
    name: "Honeymoon Advice",
    description: "Congratulations, you’re married! Now it’s time to celebrate with an incredible getaway. Whether you’ll be lounging on a tropical beach, hiking towering peaks, sipping wine in a famed vineyard, or wandering historic streets, we’ve compiled some of the best destinations (plus need-to-know travel tips) so you can enjoy this trip of a lifetime with your new spouse."
  },
  {
    name: "Budget",
    description: "Creating your wedding budget is a major task, but it has to be done before you can get to planning. We’ve got tips and tricks to help you figure out how much to spend, allocate your budget to fit your priorities, cut costs, and identify where it’s worth it to splurge so you can make the most of every cent."
  },
  {
    name: "Legal Paperwork",
    description: "Who knew getting married came with so much paperwork? There’s a lot to get in order to make sure it’s legal when you say 'I do,' but don’t worry – we’re here to help. From the documentation you’ll need to the processes you’ll need to follow, this is what it takes to get officially hitched."
  },
  {
    name: "Trends & Tips",
    description: "Planning a wedding is an exciting, once-in-a-lifetime experience, but sometimes it’s hard to know where to begin. We’re here with gorgeous inspiration, exciting ideas, and can’t-miss advice to make wedding planning fun and stress-free. Just like your love story, no two wedding days are the same – so make yours really stand out."
  },
  {
    name: "Etiquette",
    description: "Manners matter, especially when it comes to your wedding day. From choosing your wedding party to finalizing your reception seating chart, there’s etiquette to consider every step of the way. Whether it’s a timeless question every couple faces or an unexpected tricky situation, we’ll help you navigate wedding etiquette so you’re ready to handle it all."
  },
  {
    name: "Marriage Proposals",
    description: "This is how the story begins. When you’re ready to get down on one knee, we’re here for you with advice on where to pop the question, how to personalize your proposal, and the best ways to let the world know you’re engaged after your perfect proposal leads to an ecstatic 'Yes!'."
  },
  {
    name: "Wedding Registry",
    description: "Kick off married life in style with a wedding registry that fits the two of you to a T. From can’t-miss basics to tips for creating your dream honeymoon registry, our expert advice will make setting up a wedding registry a breeze for you, and buying the right gift easy for your guests."
  }
].each do |f|
  TopicCategory.find(1).topics.find_or_create_by!(f)
end

[
  {
    name: "Officiants",
    description: "Your officiant is the real ceremony MVP, whether you choose a religious leader, celebrant, or justice of the peace. The person who performs your marriage sets the tone for the entire ceremony, so here’s how to choose the right one and work with him or her to create the ceremony of your dreams."
  },
  {
    name: "Vows & Readings",
    description: "Putting your feelings into words can be a challenge, so we’re here to help you write those all-important wedding vows. We’ve got foolproof inspiration, tips to overcome writer’s block so you can get express your emotions on paper, and the perfect readings that show why your love story is one worth celebrating."
  },
  {
    name: "Traditions",
    description: "A wedding ceremony is about more than just “I do” – it’s the rituals and traditions you choose that make each moment extra sentimental. From choosing who will walk you down the aisle to picking just the right ritual to symbolize your union, this is the place to find the perfect traditions for your big day."
  }
].each do |f|
  TopicCategory.find(2).topics.find_or_create_by!(f)
end

[
  {
    name: "Places to Celebrate",
    description: "Location, location, location. Bringing your vision to life starts with finding the right wedding venue, whether it’s a modern museum, a grand hotel ballroom, or a beautifully restored barn. But where should you start your search? Don’t worry, we’ve got fantastic options for every wedding style – and every budget."
  },
  {
    name: "Food & Beverage",
    description: "Choosing your wedding menu can be fun (hello, tastings!) but it’s also important, since what you select can make or break the celebration. We’re here to make bad wedding meals a thing of the past with ideas on what to serve, how to serve it, and how much to spend so you can fuel the party in mouthwatering fashion."
  },
  {
    name: "Cake & Desserts",
    description: "A wedding cake is just as much a part of your event's design as it is a sweet ending to the meal. Whether you’re all about a multi-tiered creation covered in flowers or have visions of a table laden with your favorite sugary goodies, we’ve got all the inspiration and resources you’ll need. Save room for dessert!"
  },
  {
    name: "Favors",
    description: "Finding the right wedding favor is a lot harder than it sounds, but it doesn’t have to be. These ideas will help you pick the perfect gift to thank your guests for being a part of your wedding day, whether it’s a delicious late-night treat or a chic keepsake."
  },
  {
    name: "Speeches & Traditions",
    description: "There’s nothing like a great wedding speech, whether it’s poignant and tear-jerking or laugh-out-loud funny. If you need help writing the perfect best man toast, drafting a short-and-sweet thank you, or figuring out who should speak when, look no further. Grab a pen and get ready to raise your glass!"
  }
].each do |f|
  TopicCategory.find(3).topics.find_or_create_by!(f)
end

[
  {
    name: "Transportation",
    description: "You’ve got every detail of your wedding celebration planned, but how will you get there? From a vintage trolley to a classic limo, the grand entrance to the romantic getaway, these tips will help you arrive in style, on time, and under budget."
  },
  {
    name: "Photography & Video",
    description: "Your wedding day will go by in the blink of an eye, so make sure you’ve got a great photographer and videographer on-hand to capture those special moments. After all, a picture is worth a thousand words! Here’s how to find the best professionals for the job."
  },
  {
    name: "Invitations & Stationery",
    description: "You didn’t know you cared so much about paper weight, fonts, or postage… until now. Your wedding invitations and stationery are more than a way to keep guests informed. They’re a part of your celebration’s aesthetic, from the first save-the-date to the final thank you note. Whether classic, rustic, modern, or vintage, here’s how to make that paper count."
  },
  {
    name: "Wedding Flowers",
    description: "What would a wedding be without flowers? Picking the right blooms is a process, and there’s a lot you need to know before choosing your bouquet or designing your centerpieces. We’ve got everything you need to know, from that all-important vocabulary to tips for hiring a fantastic florist and keeping your flower budget in-check."
  },
  {
    name: "Wedding Songs & Music",
    description: "You and your partner have “your” song, but there’s a lot more to wedding day music than just your first dance! If you’re choosing between a band and a DJ, finessing your playlist, or seeking the best songs for those key moments, this is the essential information you need to keep the party going all night long."
  },
  {
    name: "Wedding Decor",
    description: "It’s time to start designing! Whether your style is classic and elegant, refined and rustic, romantically vintage, or modern and sleek, we’ve got the inspiration you need to bring your vision to life. These tips and trends (plus inspiration from some of our favorite wedding pros!) will help you make your big day totally unique."
  }
].each do |f|
  TopicCategory.find(4).topics.find_or_create_by!(f)
end

[
  {
    name: "Rings & Jewelry",
    description: "A wedding ring is something you’ll wear every day, so choosing the right one can seem like a tall order. Don’t worry, we’re here to help! Whether you’re searching for the perfect engagement ring, are in the market for just the right wedding band, or want to give your partner an heirloom-worthy gift, this is advice you won’t want to miss."
  },
  {
    name: "Bride & Bridesmaids",
    description: "Finding the perfect wedding dress can be overwhelming (seriously, who knew there were so many white dresses?!) but there’s one out there for you, we promise! We’re here to help you find the wedding gown of your dreams, the must-have accessories, and gorgeous bridesmaids’ dresses that your bridal party will adore. Let’s get shopping!"
  },
  {
    name: "Groom & Groomsmen",
    description: "There’s more to it than slipping on a jacket and heading to the altar. We’ve decoded all of the suit and tux vocabulary you’ll need, outlined the must-have accessories that will really make your look, and will even help you dress your groomsmen. It’s time to practice tying that bowtie!"
  }
].each do |f|
  TopicCategory.find(5).topics.find_or_create_by!(f)
end

[
  {
    name: "Bridal Hair",
    description: "The last thing you want on your wedding day is ho-hum hair. Whether you need help finding (and hiring!) the perfect stylist, are searching for gorgeous inspiration photos, or are in the market for the best accessories for your updo, we’re here to make sure your curls, braids, and waves are totally swoon-worthy."
  },
  {
    name: "Beauty Tips",
    description: "Whether you’re hiring a professional or going the DIY route, every bride wants to look fantastic on her wedding day. From perfecting your beauty routine and choosing the best color for your bridal manicure to need-to-know tips on hiring a makeup artist, we’ve got the advice and insight to get you looking your best!"
  },
  {
    name: "Grooming",
    description: "This one’s for the boys. There’s more to getting wedding-ready than a haircut and a shave, so we’ve got the do’s and don’ts you or your partner might need to take your look to the next level. After all, the groom’s got to look good, too!"
  }
].each do |f|
  TopicCategory.find(6).topics.find_or_create_by!(f)
end

[
  {
    name: "Locations",
    description: "If you’ve got your heart set on a destination wedding, the first thing you need to figure out is where it will be! Whether you’re looking for a big city, a rustic ranch, or the perfect sandy beach, we’ve rounded up the best locations to help you find just the spot to say “I do.”"
  },
  {
    name: "Advice and Etiquette",
    description: "There’s lots of etiquette to consider when planning a destination wedding. You’ve got to make sure your guests are kept in the loop, be an extra-accommodating host, and keep an eye on local customs so you and your loved ones don’t commit any faux-pas. These are the destination wedding details you need to know."
  }
].each do |f|
  TopicCategory.find(7).topics.find_or_create_by!(f)
end

[
  {
    name: "Finances",
    description: "There’s nothing romantic about discussing money, but it has to be done. Whether you’re looking to combine your finances, want to make a big investment in something like a house, or are getting ready to start a family of your own, these articles will help you start the conversation and take some of the stress away so you can make the most of your money."
  }
].each do |f|
  TopicCategory.find(8).topics.find_or_create_by!(f)
end

[
  {
    name: "Engagement Party",
    description: "Your partner popped the question, so it’s time to pop some champagne! Whether the two of you are hosting or a friend is taking the reins, this celebration will really set the tone for your engagement. From who to invite to where the party should go down, here’s everything you need to know for an engagement party that marks the occasion in style."
  },
  {
    name: "Bridal & Wedding Showers",
    description: "This party brings some of the bride or couple's closest friends and relatives together to shower them in excitement, advice, and gifts. But it’s not a one-size-fits-all party. Here’s how to make this moment special, plus planning tips and etiquette to keep things running smoothly."
  }
].each do |f|
  TopicCategory.find(9).topics.find_or_create_by!(f)
end

[
  {
    name: "Wedding Party",
    description: "Your wedding squad will be the evening’s VIPs, and deciding who makes the cut can be quite an undertaking. We’ve got tips and advice to help you pick your bridesmaids and groomsmen, nominate your maid of honor and best man, choose the best gifts to thank them for their help, and handle flower girls and ring bearers who get sudden stage fright once the music starts."
  },
  {
    name: "Relatives",
    description: "A wedding brings families together, which is both wonderful and a little stressful. From Momzilla to an opinionated aunt, there are so many personalities to manage. Don’t let family dynamics get the best of you! Use these tips to smooth ruffled feathers and ensure everyone has a really great time."
  }
].each do |f|
  TopicCategory.find(10).topics.find_or_create_by!(f)
end
