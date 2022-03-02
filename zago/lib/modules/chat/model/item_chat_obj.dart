class ItemChatObj {
  String messsage;
  String imagePath;
  String audioPath;

  TypeMessage type;
  bool isFromMe;

  ItemChatObj(
      {this.messsage = "",
      this.imagePath = "",
      this.audioPath = "",
      this.type = TypeMessage.text,
      this.isFromMe = false});
}

enum TypeMessage { text, image, audio, icons }

List<ItemChatObj> fakeListItemChat = [
  ItemChatObj(
      messsage: 'Chung cư ở thành phố Chernihiv trúng rocket', isFromMe: true),
  ItemChatObj(messsage: 'Trong khi G7', isFromMe: false),
  ItemChatObj(
      isFromMe: true,
      messsage:
          'Lực lượng Nga tiến vào thành phố Berdyansk ở miền nam Ukraine, bắt đầu bao vây, pháo kích Chernihiv và căn cứ không quân Vasylki ở ngoại ô thủ đô Kiev, khi chiến dịch quân sự đặc biệt bước sang ngày thứ năm. Nga có thể đổi chiến thuật sau khi đà tiến quân chậm lại vì vấp phải kháng cự dữ dội từ quân đội Ukraine, cũng như đối mặt thách thức về hậu cần.'),
  ItemChatObj(
      isFromMe: false,
      messsage:
          'Tổng thống Brazil Jair Bolsonaro cho biết nước này sẽ "áp dụng lập trường trung lập đối với Ukraine" và không thực hiện lệnh trừng phạt Nga'),
  ItemChatObj(isFromMe: true, messsage: 'Một rocket đánh trúng toà nhà dân'),
  ItemChatObj(isFromMe: false, messsage: 'cháy'),
  ItemChatObj(
      messsage: 'Chung cư ở thành phố Chernihiv trúng rocket', isFromMe: true),
  ItemChatObj(messsage: 'Trong khi G7', isFromMe: false),
  ItemChatObj(
      isFromMe: true,
      messsage:
          'Lực lượng Nga tiến vào thành phố Berdyansk ở miền nam Ukraine, bắt đầu bao vây, pháo kích Chernihiv và căn cứ không quân Vasylki ở ngoại ô thủ đô Kiev, khi chiến dịch quân sự đặc biệt bước sang ngày thứ năm. Nga có thể đổi chiến thuật sau khi đà tiến quân chậm lại vì vấp phải kháng cự dữ dội từ quân đội Ukraine, cũng như đối mặt thách thức về hậu cần.'),
  ItemChatObj(
      isFromMe: false,
      messsage:
          'Tổng thống Brazil Jair Bolsonaro cho biết nước này sẽ "áp dụng lập trường trung lập đối với Ukraine" và không thực hiện lệnh trừng phạt Nga'),
  ItemChatObj(isFromMe: true, messsage: 'Một rocket đánh trúng toà nhà dân'),
  ItemChatObj(isFromMe: false, messsage: 'cháy'),
];
