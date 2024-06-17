package com.clouify.stockservice.repository;

import com.clouify.stockservice.entity.Stock;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface StockRepository extends JpaRepository<Stock, UUID> {
    Stock findByName(String name);
}
