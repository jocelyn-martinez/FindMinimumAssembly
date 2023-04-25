; A solution for Week 15 day 2: finding the minimum element in an array
;
; Jocelyn Martinez
; April 2023

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

; Declarations.  Note that we just declare an initialized array of integers.
.DATA
resultp BYTE    "The minimum in that array is", 0
resulta BYTE    10 DUP (?)
array   DWORD   5, 20, 10, 34, 100, 2400, 2, -7, 3, -5, 4           ; The length of this array is 11

.CODE
_MainProc PROC

        ; Load up the parameters
        mov     eax, 0   
        push    eax   
        mov     eax, 11
        push    eax    
		lea     eax, array
		push    eax  

        ; Now make the call
		mov     eax, [eax]
        call    findmin  

        ; Return: adjust the stack (throw away the parameters), print, quit.
        add     esp, 12     ; discard two of the parameters  

        dtoa    resulta, eax		
        output  resultp, resulta
              
quit:   mov     eax, 0      ; exit with return code 0
        ret
_MainProc   ENDP        

findmin	PROC
                                  ; Using ebx for the array
        push    ebp                  ; Save stack
        mov     ebp, esp             ; Set base pointer
        push    ebx
        push    ecx
        push    edx
        push    esi
        push    edi
        mov     ebx, [ebp+8]         ; Retrieving the array
        mov     ecx, [ebp+12]        ; Retrieving the size
        mov     eax, [ebp+16]        ; Retrieving start
        mov     edx, eax
        inc     edx
        cmp     edx, ecx
        jne     recurse              ; Jump to recurse because there are still elements to go through.
    baseCase:                     ; Base case at the end of the array
        mov     eax, [ebx+eax*4]
        jmp     done
    recurse:
        mov     esi, [ebx+eax*4]      ; Left element
        mov     edx, eax
        inc     edx
        push    edx                   ; Placing start+1 into the stack
        push    ecx                   ; Placing the array size into the stack
        push    ebx                   ; Placing the address of the array into the stack
        call    findmin               ; Recursively calling findMin
        pop     ebx
        pop     ecx
        pop     edx
        mov     edi, eax              ; Answer should be stored in eax
        cmp     esi, edi              ; Comparing the element left and right
        jl      returnMin             ; if return right
        mov     eax, edi              ; else return left       
        jmp     done                  ; Finished here.
    returnMin:
        mov     eax, esi              ; Minimum element is the left element.
    done:
        pop  edi                      ; Reminder: It's very important to pop elements LIFO, otherwise it will mess up the code.
        pop  esi
        pop  edx
        pop  ecx
        pop  ebx
        pop  ebp
 
        ret                  
		
findmin ENDP

END                             ; end of source code
