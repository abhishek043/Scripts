package main
  
  import (
  	"crypto/aes"
  	"crypto/cipher"
  	"crypto/rand"
  	"encoding/hex"
  	"fmt"
  	"io"
  //	"os"
  )
  
  func ExampleNewGCM_encrypt() {
  	// The key argument should be the AES key, either 16 or 32 bytes
  	// to select AES-128 or AES-256.
  	key := []byte("AES256Key-32Characters1234567890")
  	plaintext := []byte("exampleplaintext")
  
  	block, err := aes.NewCipher(key)
  	if err != nil {
  		panic(err.Error())
  	}
  
  	// Never use more than 2^32 random nonces with a given key because of the risk of a repeat.
  	nonce := make([]byte, 12)
  	if _, err := io.ReadFull(rand.Reader, nonce); err != nil {
  		panic(err.Error())
  	}
  
  	aesgcm, err := cipher.NewGCM(block)
  	if err != nil {
  		panic(err.Error())
  	}
  
  	ciphertext := aesgcm.Seal(nil, nonce, plaintext, nil)
  	fmt.Printf("%x\n", ciphertext)
  }
  
  func ExampleNewGCM_decrypt() {
  	// The key argument should be the AES key, either 16 or 32 bytes
  	// to select AES-128 or AES-256.
  	key := []byte("AES256Key-32Characters1234567890")
  	ciphertext, _ := hex.DecodeString("1019aa66cd7c024f9efd0038899dae1973ee69427f5a6579eba292ffe1b5a260")
  
  	nonce, _ := hex.DecodeString("37b8e8a308c354048d245f6d")
  
  	block, err := aes.NewCipher(key)
  	if err != nil {
  		panic(err.Error())
  	}
  
  	aesgcm, err := cipher.NewGCM(block)
  	if err != nil {
  		panic(err.Error())
  	}
  
  	plaintext, err := aesgcm.Open(nil, nonce, ciphertext, nil)
  	if err != nil {
  		panic(err.Error())
  	}
  
  	fmt.Printf("%s\n", plaintext)
  	// Output: exampleplaintext
  }
	func main(){
		ExampleNewGCM_encrypt();		
		ExampleNewGCM_decrypt();
}  
