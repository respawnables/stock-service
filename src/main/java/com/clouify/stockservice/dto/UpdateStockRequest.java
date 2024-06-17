package com.clouify.stockservice.dto;

import lombok.Data;

import java.util.UUID;

@Data
public class UpdateStockRequest {
    private UUID productId;

    private Integer quantity;
}
