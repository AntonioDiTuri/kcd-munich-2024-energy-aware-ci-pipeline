package com.example;


public class Main {
    public static void main(String[] args) {
        for (int i = 0; i < 10; i++) {  // Loop 10 times (modify for endless loop: i = 0; ; )
            System.out.println("Hello world!");
            try {
                Thread.sleep(2000); // Sleep for 2 seconds (2000 milliseconds)
              } catch (InterruptedException e) {
                System.err.println("Interrupted while sleeping!");
            }
          }
    }
}