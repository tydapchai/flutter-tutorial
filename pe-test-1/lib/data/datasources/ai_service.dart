import 'package:google_generative_ai/google_generative_ai.dart';

class AIService {
  static const String _apiKey = "YOUR_API_KEY_HERE";

  Future<String> summarizeProduct(String title, String description) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: _apiKey,
      );

      final prompt = 'Hãy tóm tắt ưu điểm và nhược điểm của sản phẩm này trong 3 gạch đầu dòng ngắn gọn để người dùng dễ mua hàng. Title: $title. Description: $description.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      return response.text ?? 'Không thể tóm tắt sản phẩm.';
    } catch (e) {
      return 'Lỗi khi gọi AI: Vui lòng thay thế YOUR_API_KEY_HERE bằng Gemini API Key thật của bạn trong data/datasources/ai_service.dart.\nChi tiết: $e';
    }
  }
}
