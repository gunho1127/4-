package com.reaplette.admin.service;

import com.reaplette.admin.mappers.AdminMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

@Service
@Log4j2
@RequiredArgsConstructor
public class AdminService {
    private final AdminMapper adminMapper;
}
