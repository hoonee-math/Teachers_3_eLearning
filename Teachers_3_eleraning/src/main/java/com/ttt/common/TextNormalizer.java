package com.ttt.common;

import java.text.Normalizer;

public class TextNormalizer {
    public String normalizeText(String input) {
        // NFD 형식으로 저장된 텍스트를 NFC 형식으로 변환
        return Normalizer.normalize(input, Normalizer.Form.NFC);
    }
}
