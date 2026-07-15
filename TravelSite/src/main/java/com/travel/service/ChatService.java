package com.travel.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.travel.dto.ChatDTO;
import com.travel.mapper.ChatMapper;

@Service
public class ChatService {

	@Autowired
	private ChatMapper chatMapper;
    @Autowired
    private RestTemplate restTemplate;

    @Value("${gemini.api.key}")
    private String apiKey;

    @Value("${gemini.api.url}")
    private String apiUrl;

    public String askGemini(String userQuestion) {
        try {
            // 요청 헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            // 여행 상담 챗봇이라는 역할을 부여하는 프롬프트
            String systemPrompt = "당신은 여행 전문 상담 챗봇입니다. 사용자의 여행 관련 질문에 친절하고 "
                    + "구체적으로 답변해주세요. 여행지 추천, 예산 짜기, 일정 계획 등을 도와주세요. "
                    + "답변은 한국어로, 너무 길지 않게 핵심 위주로 작성해주세요.\n\n사용자 질문: " + userQuestion;

            // 요청 본문 구성 (Gemini API 형식)
            Map<String, Object> requestBody = new HashMap<>();
            List<Map<String, Object>> contents = new ArrayList<>();
            Map<String, Object> content = new HashMap<>();
            List<Map<String, String>> parts = new ArrayList<>();
            Map<String, String> part = new HashMap<>();
            part.put("text", systemPrompt);
            parts.add(part);
            content.put("parts", parts);
            contents.add(content);
            requestBody.put("contents", contents);

            HttpEntity<Map<String, Object>> request = new HttpEntity<>(requestBody, headers);

            // API 호출 (키는 쿼리 파라미터로 전달)
            String urlWithKey = apiUrl + "?key=" + apiKey;
            ResponseEntity<String> response = restTemplate.postForEntity(urlWithKey, request, String.class);

            // 응답 JSON에서 텍스트만 추출
            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(response.getBody());
            String answer = root.path("candidates").get(0)
                    .path("content").path("parts").get(0)
                    .path("text").asText();

            return answer;

        } catch (Exception e) {
            e.printStackTrace();
            return "죄송합니다, 답변을 생성하는 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.";
        }
    }
    
    // 대화 기록 저장 (로그인한 회원만)
    public void saveChatLog(int memberId, String question, String answer) {
        ChatDTO chat = new ChatDTO();
        chat.setMemberId(memberId);
        chat.setQuestion(question);
        chat.setAnswer(answer);
        chatMapper.insertChatLog(chat);
    }

    // 내 대화 기록 조회
    public List<ChatDTO> getMyChats(int memberId) {
        return chatMapper.selectChatsByMemberId(memberId);
    }
}