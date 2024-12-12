package com.reaplette.service;

import com.reaplette.search.service.SearchService;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

@SpringBootTest
@ExtendWith(SpringExtension.class)
@Log4j2
public class SearchServiceTests {
    @Autowired
    private SearchService searchService;

    @Test
    public void testGetBookCategoryInfo() {
        log.info(searchService.getBookCategoryInfo("9788936434120"));
    }

}
