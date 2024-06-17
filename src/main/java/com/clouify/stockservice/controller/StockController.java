package com.clouify.stockservice.controller;

import com.clouify.stockservice.dto.UpdateStockRequest;
import com.clouify.stockservice.entity.Stock;
import com.clouify.stockservice.service.StockService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/stocks")
public class StockController {

    private final StockService stockService;

    public StockController(StockService stockService) {
        this.stockService = stockService;
    }

    @GetMapping
    public ResponseEntity<List<Stock>> getAllStocks() {
        return ResponseEntity.ok(stockService.getAllStocks());
    }

    @PostMapping("/add")
    public ResponseEntity<Stock> addProduct(@RequestBody final Stock stock) {
        return ResponseEntity.ok(stockService.addProduct(stock));
    }

    @PostMapping("/update")
    public ResponseEntity<Void> updateStock(@RequestBody final UpdateStockRequest updateStockRequest) {
        stockService.updateStock(updateStockRequest.getProductId(), updateStockRequest.getQuantity());
        return ResponseEntity.ok().build();
    }

    @GetMapping("/check")
    public ResponseEntity<Boolean> checkStock(@RequestParam final UUID productId,
                                              @RequestParam final Integer quantity) {
        return ResponseEntity.ok(stockService.isStockAvailable(productId, quantity));
    }
}
