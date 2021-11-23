
_ssd1306_command:

;ssd1306.c,194 :: 		void ssd1306_command(uint8_t c) {
;ssd1306.c,195 :: 		uint8_t control = 0x00;   // Co = 0, D/C = 0
	CLRF       ssd1306_command_control_L0+0
;ssd1306.c,196 :: 		SSD1306_Start();
	CALL       _I2C1_Start+0
;ssd1306.c,197 :: 		SSD1306_Write(_i2caddr);
	MOVF       __i2caddr+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ssd1306.c,198 :: 		SSD1306_Write(control);
	MOVF       ssd1306_command_control_L0+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ssd1306.c,199 :: 		SSD1306_Write(c);
	MOVF       FARG_ssd1306_command_c+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ssd1306.c,200 :: 		SSD1306_Stop();
	CALL       _I2C1_Stop+0
;ssd1306.c,201 :: 		}
L_end_ssd1306_command:
	RETURN
; end of _ssd1306_command

_SSD1306_Init:

;ssd1306.c,203 :: 		void SSD1306_Init(uint8_t vccstate, uint8_t i2caddr) {
;ssd1306.c,204 :: 		_vccstate = vccstate;
	MOVF       FARG_SSD1306_Init_vccstate+0, 0
	MOVWF      __vccstate+0
;ssd1306.c,205 :: 		_i2caddr  = i2caddr;
	MOVF       FARG_SSD1306_Init_i2caddr+0, 0
	MOVWF      __i2caddr+0
;ssd1306.c,207 :: 		SSD1306_RST = 0;
	BCF        RA0_bit+0, BitPos(RA0_bit+0)
;ssd1306.c,209 :: 		SSD1306_RST_DIR = 0;
	BCF        TRISA0_bit+0, BitPos(TRISA0_bit+0)
;ssd1306.c,211 :: 		delay_ms(10);
	MOVLW      52
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_SSD1306_Init0:
	DECFSZ     R13+0, 1
	GOTO       L_SSD1306_Init0
	DECFSZ     R12+0, 1
	GOTO       L_SSD1306_Init0
	NOP
	NOP
;ssd1306.c,212 :: 		SSD1306_RST = 1;
	BSF        RA0_bit+0, BitPos(RA0_bit+0)
;ssd1306.c,215 :: 		ssd1306_command(SSD1306_DISPLAYOFF);                    // 0xAE
	MOVLW      174
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,216 :: 		ssd1306_command(SSD1306_SETDISPLAYCLOCKDIV);            // 0xD5
	MOVLW      213
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,217 :: 		ssd1306_command(0x80);                                  // the suggested ratio 0x80
	MOVLW      128
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,219 :: 		ssd1306_command(SSD1306_SETMULTIPLEX);                  // 0xA8
	MOVLW      168
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,220 :: 		ssd1306_command(SSD1306_LCDHEIGHT - 1);
	MOVLW      63
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,222 :: 		ssd1306_command(SSD1306_SETDISPLAYOFFSET);              // 0xD3
	MOVLW      211
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,223 :: 		ssd1306_command(0x0);                                   // no offset
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,224 :: 		ssd1306_command(SSD1306_SETSTARTLINE | 0x0);            // line #0
	MOVLW      64
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,225 :: 		ssd1306_command(SSD1306_CHARGEPUMP);                    // 0x8D
	MOVLW      141
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,226 :: 		if (vccstate == SSD1306_EXTERNALVCC)
	MOVF       FARG_SSD1306_Init_vccstate+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SSD1306_Init1
;ssd1306.c,227 :: 		{ ssd1306_command(0x10); }
	MOVLW      16
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
	GOTO       L_SSD1306_Init2
L_SSD1306_Init1:
;ssd1306.c,229 :: 		{ ssd1306_command(0x14); }
	MOVLW      20
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
L_SSD1306_Init2:
;ssd1306.c,230 :: 		ssd1306_command(SSD1306_MEMORYMODE);                    // 0x20
	MOVLW      32
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,231 :: 		ssd1306_command(0x00);                                  // 0x0 act like ks0108
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,232 :: 		ssd1306_command(SSD1306_SEGREMAP | 0x1);
	MOVLW      161
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,233 :: 		ssd1306_command(SSD1306_COMSCANDEC);
	MOVLW      200
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,242 :: 		ssd1306_command(SSD1306_SETCOMPINS);                    // 0xDA
	MOVLW      218
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,243 :: 		ssd1306_command(0x12);
	MOVLW      18
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,244 :: 		ssd1306_command(SSD1306_SETCONTRAST);                   // 0x81
	MOVLW      129
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,245 :: 		if (vccstate == SSD1306_EXTERNALVCC)
	MOVF       FARG_SSD1306_Init_vccstate+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SSD1306_Init3
;ssd1306.c,246 :: 		{ ssd1306_command(0x9F); }
	MOVLW      159
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
	GOTO       L_SSD1306_Init4
L_SSD1306_Init3:
;ssd1306.c,248 :: 		{ ssd1306_command(0xCF); }
	MOVLW      207
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
L_SSD1306_Init4:
;ssd1306.c,261 :: 		ssd1306_command(SSD1306_SETPRECHARGE);                  // 0xd9
	MOVLW      217
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,262 :: 		if (vccstate == SSD1306_EXTERNALVCC)
	MOVF       FARG_SSD1306_Init_vccstate+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SSD1306_Init5
;ssd1306.c,263 :: 		{ ssd1306_command(0x22); }
	MOVLW      34
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
	GOTO       L_SSD1306_Init6
L_SSD1306_Init5:
;ssd1306.c,265 :: 		{ ssd1306_command(0xF1); }
	MOVLW      241
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
L_SSD1306_Init6:
;ssd1306.c,266 :: 		ssd1306_command(SSD1306_SETVCOMDETECT);                 // 0xDB
	MOVLW      219
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,267 :: 		ssd1306_command(0x40);
	MOVLW      64
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,268 :: 		ssd1306_command(SSD1306_DISPLAYALLON_RESUME);           // 0xA4
	MOVLW      164
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,269 :: 		ssd1306_command(SSD1306_NORMALDISPLAY);                 // 0xA6
	MOVLW      166
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,271 :: 		ssd1306_command(SSD1306_DEACTIVATE_SCROLL);
	MOVLW      46
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,273 :: 		ssd1306_command(SSD1306_DISPLAYON);//--turn on oled panel
	MOVLW      175
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,274 :: 		}
L_end_SSD1306_Init:
	RETURN
; end of _SSD1306_Init

_SSD1306_StartScrollRight:

;ssd1306.c,276 :: 		void SSD1306_StartScrollRight(uint8_t start, uint8_t stop) {
;ssd1306.c,277 :: 		ssd1306_command(SSD1306_RIGHT_HORIZONTAL_SCROLL);
	MOVLW      38
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,278 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,279 :: 		ssd1306_command(start);  // start page
	MOVF       FARG_SSD1306_StartScrollRight_start+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,280 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,281 :: 		ssd1306_command(stop);   // end page
	MOVF       FARG_SSD1306_StartScrollRight_stop+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,282 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,283 :: 		ssd1306_command(0XFF);
	MOVLW      255
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,284 :: 		ssd1306_command(SSD1306_ACTIVATE_SCROLL);
	MOVLW      47
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,285 :: 		}
L_end_SSD1306_StartScrollRight:
	RETURN
; end of _SSD1306_StartScrollRight

_SSD1306_StartScrollLeft:

;ssd1306.c,287 :: 		void SSD1306_StartScrollLeft(uint8_t start, uint8_t stop) {
;ssd1306.c,288 :: 		ssd1306_command(SSD1306_LEFT_HORIZONTAL_SCROLL);
	MOVLW      39
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,289 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,290 :: 		ssd1306_command(start);
	MOVF       FARG_SSD1306_StartScrollLeft_start+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,291 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,292 :: 		ssd1306_command(stop);
	MOVF       FARG_SSD1306_StartScrollLeft_stop+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,293 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,294 :: 		ssd1306_command(0XFF);
	MOVLW      255
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,295 :: 		ssd1306_command(SSD1306_ACTIVATE_SCROLL);
	MOVLW      47
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,296 :: 		}
L_end_SSD1306_StartScrollLeft:
	RETURN
; end of _SSD1306_StartScrollLeft

_SSD1306_StartScrollDiagRight:

;ssd1306.c,298 :: 		void SSD1306_StartScrollDiagRight(uint8_t start, uint8_t stop) {
;ssd1306.c,299 :: 		ssd1306_command(SSD1306_SET_VERTICAL_SCROLL_AREA);
	MOVLW      163
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,300 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,301 :: 		ssd1306_command(SSD1306_LCDHEIGHT);
	MOVLW      64
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,302 :: 		ssd1306_command(SSD1306_VERTICAL_AND_RIGHT_HORIZONTAL_SCROLL);
	MOVLW      41
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,303 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,304 :: 		ssd1306_command(start);
	MOVF       FARG_SSD1306_StartScrollDiagRight_start+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,305 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,306 :: 		ssd1306_command(stop);
	MOVF       FARG_SSD1306_StartScrollDiagRight_stop+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,307 :: 		ssd1306_command(0X01);
	MOVLW      1
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,308 :: 		ssd1306_command(SSD1306_ACTIVATE_SCROLL);
	MOVLW      47
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,309 :: 		}
L_end_SSD1306_StartScrollDiagRight:
	RETURN
; end of _SSD1306_StartScrollDiagRight

_SSD1306_StartScrollDiagLeft:

;ssd1306.c,311 :: 		void SSD1306_StartScrollDiagLeft(uint8_t start, uint8_t stop) {
;ssd1306.c,312 :: 		ssd1306_command(SSD1306_SET_VERTICAL_SCROLL_AREA);
	MOVLW      163
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,313 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,314 :: 		ssd1306_command(SSD1306_LCDHEIGHT);
	MOVLW      64
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,315 :: 		ssd1306_command(SSD1306_VERTICAL_AND_LEFT_HORIZONTAL_SCROLL);
	MOVLW      42
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,316 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,317 :: 		ssd1306_command(start);
	MOVF       FARG_SSD1306_StartScrollDiagLeft_start+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,318 :: 		ssd1306_command(0X00);
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,319 :: 		ssd1306_command(stop);
	MOVF       FARG_SSD1306_StartScrollDiagLeft_stop+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,320 :: 		ssd1306_command(0X01);
	MOVLW      1
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,321 :: 		ssd1306_command(SSD1306_ACTIVATE_SCROLL);
	MOVLW      47
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,322 :: 		}
L_end_SSD1306_StartScrollDiagLeft:
	RETURN
; end of _SSD1306_StartScrollDiagLeft

_SSD1306_StopScroll:

;ssd1306.c,324 :: 		void SSD1306_StopScroll(void) {
;ssd1306.c,325 :: 		ssd1306_command(SSD1306_DEACTIVATE_SCROLL);
	MOVLW      46
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,326 :: 		}
L_end_SSD1306_StopScroll:
	RETURN
; end of _SSD1306_StopScroll

_SSD1306_Dim:

;ssd1306.c,328 :: 		void SSD1306_Dim(uint8_t dim) {
;ssd1306.c,330 :: 		if (dim & 1)
	BTFSS      FARG_SSD1306_Dim_dim+0, 0
	GOTO       L_SSD1306_Dim7
;ssd1306.c,331 :: 		contrast = 0; // Dimmed display
	CLRF       SSD1306_Dim_contrast_L0+0
	GOTO       L_SSD1306_Dim8
L_SSD1306_Dim7:
;ssd1306.c,333 :: 		if (_vccstate == SSD1306_EXTERNALVCC)
	MOVF       __vccstate+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SSD1306_Dim9
;ssd1306.c,334 :: 		contrast = 0x9F;
	MOVLW      159
	MOVWF      SSD1306_Dim_contrast_L0+0
	GOTO       L_SSD1306_Dim10
L_SSD1306_Dim9:
;ssd1306.c,336 :: 		contrast = 0xCF;
	MOVLW      207
	MOVWF      SSD1306_Dim_contrast_L0+0
L_SSD1306_Dim10:
;ssd1306.c,337 :: 		}
L_SSD1306_Dim8:
;ssd1306.c,340 :: 		ssd1306_command(SSD1306_SETCONTRAST);
	MOVLW      129
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,341 :: 		ssd1306_command(contrast);
	MOVF       SSD1306_Dim_contrast_L0+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,342 :: 		}
L_end_SSD1306_Dim:
	RETURN
; end of _SSD1306_Dim

_SSD1306_SetTextWrap:

;ssd1306.c,344 :: 		void SSD1306_SetTextWrap(uint8_t w) {
;ssd1306.c,345 :: 		wrap = w & 1;
	MOVLW      1
	ANDWF      FARG_SSD1306_SetTextWrap_w+0, 0
	MOVWF      _wrap+0
;ssd1306.c,346 :: 		}
L_end_SSD1306_SetTextWrap:
	RETURN
; end of _SSD1306_SetTextWrap

_SSD1306_InvertDisplay:

;ssd1306.c,348 :: 		void SSD1306_InvertDisplay(uint8_t i) {
;ssd1306.c,349 :: 		if (i & 1)
	BTFSS      FARG_SSD1306_InvertDisplay_i+0, 0
	GOTO       L_SSD1306_InvertDisplay11
;ssd1306.c,350 :: 		ssd1306_command(SSD1306_INVERTDISPLAY_);
	MOVLW      167
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
	GOTO       L_SSD1306_InvertDisplay12
L_SSD1306_InvertDisplay11:
;ssd1306.c,352 :: 		ssd1306_command(SSD1306_NORMALDISPLAY);
	MOVLW      166
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
L_SSD1306_InvertDisplay12:
;ssd1306.c,353 :: 		}
L_end_SSD1306_InvertDisplay:
	RETURN
; end of _SSD1306_InvertDisplay

_SSD1306_GotoXY:

;ssd1306.c,355 :: 		void SSD1306_GotoXY(uint8_t x, uint8_t y) {
;ssd1306.c,356 :: 		if((x > SSD1306_LCDWIDTH / 6) || y > SSD1306_LCDHEIGHT / 8)
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SSD1306_GotoXY137
	MOVF       FARG_SSD1306_GotoXY_x+0, 0
	SUBLW      21
L__SSD1306_GotoXY137:
	BTFSS      STATUS+0, 0
	GOTO       L__SSD1306_GotoXY118
	MOVF       FARG_SSD1306_GotoXY_y+0, 0
	SUBLW      8
	BTFSS      STATUS+0, 0
	GOTO       L__SSD1306_GotoXY118
	GOTO       L_SSD1306_GotoXY15
L__SSD1306_GotoXY118:
;ssd1306.c,357 :: 		return;
	GOTO       L_end_SSD1306_GotoXY
L_SSD1306_GotoXY15:
;ssd1306.c,358 :: 		x_pos = x;
	MOVF       FARG_SSD1306_GotoXY_x+0, 0
	MOVWF      _x_pos+0
;ssd1306.c,359 :: 		y_pos = y;
	MOVF       FARG_SSD1306_GotoXY_y+0, 0
	MOVWF      _y_pos+0
;ssd1306.c,360 :: 		}
L_end_SSD1306_GotoXY:
	RETURN
; end of _SSD1306_GotoXY

_SSD1306_PutC:

;ssd1306.c,362 :: 		void SSD1306_PutC(char c) {
;ssd1306.c,364 :: 		if((c < ' ') || (c > '~'))
	MOVLW      32
	SUBWF      FARG_SSD1306_PutC_c+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__SSD1306_PutC120
	MOVF       FARG_SSD1306_PutC_c+0, 0
	SUBLW      126
	BTFSS      STATUS+0, 0
	GOTO       L__SSD1306_PutC120
	GOTO       L_SSD1306_PutC18
L__SSD1306_PutC120:
;ssd1306.c,365 :: 		c = '?';
	MOVLW      63
	MOVWF      FARG_SSD1306_PutC_c+0
L_SSD1306_PutC18:
;ssd1306.c,366 :: 		ssd1306_command(SSD1306_COLUMNADDR);
	MOVLW      33
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,367 :: 		ssd1306_command(6 * (x_pos - 1));
	DECF       _x_pos+0, 0
	MOVWF      R0+0
	MOVLW      6
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,368 :: 		ssd1306_command(6 * (x_pos - 1) + 4); // Column end address (127 = reset)
	DECF       _x_pos+0, 0
	MOVWF      R0+0
	MOVLW      6
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVLW      4
	ADDWF      R0+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,370 :: 		ssd1306_command(SSD1306_PAGEADDR);
	MOVLW      34
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,371 :: 		ssd1306_command(y_pos - 1); // Page start address (0 = reset)
	DECF       _y_pos+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,372 :: 		ssd1306_command(y_pos - 1); // Page end address
	DECF       _y_pos+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,374 :: 		SSD1306_Start();
	CALL       _I2C1_Start+0
;ssd1306.c,375 :: 		SSD1306_Write(_i2caddr);
	MOVF       __i2caddr+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ssd1306.c,376 :: 		SSD1306_Write(0x40);
	MOVLW      64
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ssd1306.c,378 :: 		for(i = 0; i < 5; i++ ) {
	CLRF       SSD1306_PutC_i_L0+0
L_SSD1306_PutC19:
	MOVLW      5
	SUBWF      SSD1306_PutC_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SSD1306_PutC20
;ssd1306.c,379 :: 		font_c = font[(c - 32) * 5 + i];
	MOVLW      32
	SUBWF      FARG_SSD1306_PutC_c+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      5
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       SSD1306_PutC_i_L0+0, 0
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      _Font+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_Font+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_I2C1_Wr_data_+0
;ssd1306.c,381 :: 		SSD1306_Write(font_c);
	CALL       _I2C1_Wr+0
;ssd1306.c,378 :: 		for(i = 0; i < 5; i++ ) {
	INCF       SSD1306_PutC_i_L0+0, 1
;ssd1306.c,382 :: 		}
	GOTO       L_SSD1306_PutC19
L_SSD1306_PutC20:
;ssd1306.c,383 :: 		SSD1306_Stop();
	CALL       _I2C1_Stop+0
;ssd1306.c,386 :: 		x_pos = x_pos % 21 + 1;
	MOVLW      21
	MOVWF      R4+0
	MOVF       _x_pos+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	INCF       R0+0, 0
	MOVWF      _x_pos+0
;ssd1306.c,387 :: 		if (wrap && (x_pos == 1))
	MOVF       _wrap+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SSD1306_PutC24
	MOVF       _x_pos+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SSD1306_PutC24
L__SSD1306_PutC119:
;ssd1306.c,389 :: 		y_pos = y_pos % 8 + 1;
	MOVLW      7
	ANDWF      _y_pos+0, 1
	INCF       _y_pos+0, 1
L_SSD1306_PutC24:
;ssd1306.c,400 :: 		}
L_end_SSD1306_PutC:
	RETURN
; end of _SSD1306_PutC

_SSD1306_PutCustomC:

;ssd1306.c,402 :: 		void SSD1306_PutCustomC(char *c) {
;ssd1306.c,404 :: 		ssd1306_command(SSD1306_COLUMNADDR);
	MOVLW      33
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,405 :: 		ssd1306_command(6 * (x_pos - 1));
	DECF       _x_pos+0, 0
	MOVWF      R0+0
	MOVLW      6
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,406 :: 		ssd1306_command(6 * (x_pos - 1) + 4); // Column end address (127 = reset)
	DECF       _x_pos+0, 0
	MOVWF      R0+0
	MOVLW      6
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVLW      4
	ADDWF      R0+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,408 :: 		ssd1306_command(SSD1306_PAGEADDR);
	MOVLW      34
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,409 :: 		ssd1306_command(y_pos - 1); // Page start address (0 = reset)
	DECF       _y_pos+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,410 :: 		ssd1306_command(y_pos - 1); // Page end address
	DECF       _y_pos+0, 0
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,412 :: 		SSD1306_Start();
	CALL       _I2C1_Start+0
;ssd1306.c,413 :: 		SSD1306_Write(_i2caddr);
	MOVF       __i2caddr+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ssd1306.c,414 :: 		SSD1306_Write(0x40);
	MOVLW      64
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ssd1306.c,416 :: 		for(i = 0; i < 5; i++ ) {
	CLRF       SSD1306_PutCustomC_i_L0+0
L_SSD1306_PutCustomC25:
	MOVLW      5
	SUBWF      SSD1306_PutCustomC_i_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_SSD1306_PutCustomC26
;ssd1306.c,417 :: 		line = c[i];
	MOVF       SSD1306_PutCustomC_i_L0+0, 0
	ADDWF      FARG_SSD1306_PutCustomC_c+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
;ssd1306.c,418 :: 		SSD1306_Write(line);
	CALL       _I2C1_Wr+0
;ssd1306.c,416 :: 		for(i = 0; i < 5; i++ ) {
	INCF       SSD1306_PutCustomC_i_L0+0, 1
;ssd1306.c,419 :: 		}
	GOTO       L_SSD1306_PutCustomC25
L_SSD1306_PutCustomC26:
;ssd1306.c,420 :: 		SSD1306_Stop();
	CALL       _I2C1_Stop+0
;ssd1306.c,423 :: 		x_pos = x_pos % 21 + 1;
	MOVLW      21
	MOVWF      R4+0
	MOVF       _x_pos+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	INCF       R0+0, 0
	MOVWF      _x_pos+0
;ssd1306.c,424 :: 		if (wrap && (x_pos == 1))
	MOVF       _wrap+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_SSD1306_PutCustomC30
	MOVF       _x_pos+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_SSD1306_PutCustomC30
L__SSD1306_PutCustomC121:
;ssd1306.c,426 :: 		y_pos = y_pos % 8 + 1;
	MOVLW      7
	ANDWF      _y_pos+0, 1
	INCF       _y_pos+0, 1
L_SSD1306_PutCustomC30:
;ssd1306.c,437 :: 		}
L_end_SSD1306_PutCustomC:
	RETURN
; end of _SSD1306_PutCustomC

_SSD1306_Print:

;ssd1306.c,439 :: 		void SSD1306_Print(char *s) {
;ssd1306.c,440 :: 		uint8_t i = 0;
	CLRF       SSD1306_Print_i_L0+0
;ssd1306.c,441 :: 		while (s[i] != '\0'){
L_SSD1306_Print31:
	MOVF       SSD1306_Print_i_L0+0, 0
	ADDWF      FARG_SSD1306_Print_s+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_SSD1306_Print32
;ssd1306.c,442 :: 		if (s[i] == ' ' & x_pos == 1)
	MOVF       SSD1306_Print_i_L0+0, 0
	ADDWF      FARG_SSD1306_Print_s+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      32
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R1+0
	MOVF       _x_pos+0, 0
	XORLW      1
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	MOVF       R1+0, 0
	ANDWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L_SSD1306_Print33
;ssd1306.c,443 :: 		i++;
	INCF       SSD1306_Print_i_L0+0, 1
	GOTO       L_SSD1306_Print34
L_SSD1306_Print33:
;ssd1306.c,445 :: 		SSD1306_PutC(s[i++]);
	MOVF       SSD1306_Print_i_L0+0, 0
	ADDWF      FARG_SSD1306_Print_s+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_SSD1306_PutC_c+0
	CALL       _SSD1306_PutC+0
	INCF       SSD1306_Print_i_L0+0, 1
L_SSD1306_Print34:
;ssd1306.c,446 :: 		}
	GOTO       L_SSD1306_Print31
L_SSD1306_Print32:
;ssd1306.c,447 :: 		}
L_end_SSD1306_Print:
	RETURN
; end of _SSD1306_Print

_SSD1306_ClearDisplay:

;ssd1306.c,449 :: 		void SSD1306_ClearDisplay() {
;ssd1306.c,451 :: 		ssd1306_command(SSD1306_COLUMNADDR);
	MOVLW      33
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,452 :: 		ssd1306_command(0);    // Column start address
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,454 :: 		ssd1306_command(127);  // Column end address
	MOVLW      127
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,459 :: 		ssd1306_command(SSD1306_PAGEADDR);
	MOVLW      34
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,460 :: 		ssd1306_command(0);   // Page start address (0 = reset)
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,462 :: 		ssd1306_command(7);   // Page end address
	MOVLW      7
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,469 :: 		SSD1306_Start();
	CALL       _I2C1_Start+0
;ssd1306.c,470 :: 		SSD1306_Write(_i2caddr);
	MOVF       __i2caddr+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ssd1306.c,471 :: 		SSD1306_Write(0x40);
	MOVLW      64
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ssd1306.c,473 :: 		for(i = 0; i < SSD1306_LCDHEIGHT * SSD1306_LCDWIDTH / 8; i++ )
	CLRF       SSD1306_ClearDisplay_i_L0+0
	CLRF       SSD1306_ClearDisplay_i_L0+1
L_SSD1306_ClearDisplay35:
	MOVLW      4
	SUBWF      SSD1306_ClearDisplay_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SSD1306_ClearDisplay142
	MOVLW      0
	SUBWF      SSD1306_ClearDisplay_i_L0+0, 0
L__SSD1306_ClearDisplay142:
	BTFSC      STATUS+0, 0
	GOTO       L_SSD1306_ClearDisplay36
;ssd1306.c,474 :: 		SSD1306_Write(0);
	CLRF       FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ssd1306.c,473 :: 		for(i = 0; i < SSD1306_LCDHEIGHT * SSD1306_LCDWIDTH / 8; i++ )
	INCF       SSD1306_ClearDisplay_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       SSD1306_ClearDisplay_i_L0+1, 1
;ssd1306.c,474 :: 		SSD1306_Write(0);
	GOTO       L_SSD1306_ClearDisplay35
L_SSD1306_ClearDisplay36:
;ssd1306.c,476 :: 		SSD1306_Stop();
	CALL       _I2C1_Stop+0
;ssd1306.c,478 :: 		}
L_end_SSD1306_ClearDisplay:
	RETURN
; end of _SSD1306_ClearDisplay

_SSD1306_FillScreen:

;ssd1306.c,480 :: 		void SSD1306_FillScreen() {
;ssd1306.c,482 :: 		ssd1306_command(SSD1306_COLUMNADDR);
	MOVLW      33
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,483 :: 		ssd1306_command(0);    // Column start address
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,485 :: 		ssd1306_command(127);  // Column end address
	MOVLW      127
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,490 :: 		ssd1306_command(SSD1306_PAGEADDR);
	MOVLW      34
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,491 :: 		ssd1306_command(0);   // Page start address (0 = reset)
	CLRF       FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,493 :: 		ssd1306_command(7);   // Page end address
	MOVLW      7
	MOVWF      FARG_ssd1306_command_c+0
	CALL       _ssd1306_command+0
;ssd1306.c,500 :: 		SSD1306_Start();
	CALL       _I2C1_Start+0
;ssd1306.c,501 :: 		SSD1306_Write(_i2caddr);
	MOVF       __i2caddr+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ssd1306.c,502 :: 		SSD1306_Write(0x40);
	MOVLW      64
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ssd1306.c,504 :: 		for(i = 0; i < SSD1306_LCDHEIGHT * SSD1306_LCDWIDTH / 8; i++ )
	CLRF       SSD1306_FillScreen_i_L0+0
	CLRF       SSD1306_FillScreen_i_L0+1
L_SSD1306_FillScreen38:
	MOVLW      4
	SUBWF      SSD1306_FillScreen_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__SSD1306_FillScreen144
	MOVLW      0
	SUBWF      SSD1306_FillScreen_i_L0+0, 0
L__SSD1306_FillScreen144:
	BTFSC      STATUS+0, 0
	GOTO       L_SSD1306_FillScreen39
;ssd1306.c,505 :: 		SSD1306_Write(0xFF);
	MOVLW      255
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ssd1306.c,504 :: 		for(i = 0; i < SSD1306_LCDHEIGHT * SSD1306_LCDWIDTH / 8; i++ )
	INCF       SSD1306_FillScreen_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       SSD1306_FillScreen_i_L0+1, 1
;ssd1306.c,505 :: 		SSD1306_Write(0xFF);
	GOTO       L_SSD1306_FillScreen38
L_SSD1306_FillScreen39:
;ssd1306.c,507 :: 		SSD1306_Stop();
	CALL       _I2C1_Stop+0
;ssd1306.c,509 :: 		}
L_end_SSD1306_FillScreen:
	RETURN
; end of _SSD1306_FillScreen

_main:

;Securitas.c,84 :: 		void main()
;Securitas.c,88 :: 		TRISA = 0b11111111;
	MOVLW      255
	MOVWF      TRISA+0
;Securitas.c,91 :: 		TRISD = 0XF0;
	MOVLW      240
	MOVWF      TRISD+0
;Securitas.c,92 :: 		OPTION_REG &= 0X7F; //ENABLE PULL UP
	MOVLW      127
	ANDWF      OPTION_REG+0, 1
;Securitas.c,95 :: 		TRISB = 0;
	CLRF       TRISB+0
;Securitas.c,97 :: 		I2C1_Init(400000); // initialize I2C communication with clock frequency of 400KHz
	MOVLW      10
	MOVWF      SSPADD+0
	CALL       _I2C1_Init+0
;Securitas.c,100 :: 		SSD1306_Init(SSD1306_SWITCHCAPVCC, SSD1306_I2C_ADDRESS);
	MOVLW      2
	MOVWF      FARG_SSD1306_Init_vccstate+0
	MOVLW      122
	MOVWF      FARG_SSD1306_Init_i2caddr+0
	CALL       _SSD1306_Init+0
;Securitas.c,102 :: 		SSD1306_ClearDisplay();
	CALL       _SSD1306_ClearDisplay+0
;Securitas.c,104 :: 		if( !isUserExistent('A') ){
	MOVLW      65
	MOVWF      FARG_isUserExistent_user+0
	CALL       _isUserExistent+0
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main41
;Securitas.c,107 :: 		writeEEPROM(0, 1);
	CLRF       FARG_writeEEPROM_address+0
	MOVLW      1
	MOVWF      FARG_writeEEPROM_datas+0
	CALL       _writeEEPROM+0
;Securitas.c,108 :: 		writeEEPROM(1, '1');
	MOVLW      1
	MOVWF      FARG_writeEEPROM_address+0
	MOVLW      49
	MOVWF      FARG_writeEEPROM_datas+0
	CALL       _writeEEPROM+0
;Securitas.c,109 :: 		writeEEPROM(2, '2');
	MOVLW      2
	MOVWF      FARG_writeEEPROM_address+0
	MOVLW      50
	MOVWF      FARG_writeEEPROM_datas+0
	CALL       _writeEEPROM+0
;Securitas.c,110 :: 		writeEEPROM(3, '3');
	MOVLW      3
	MOVWF      FARG_writeEEPROM_address+0
	MOVLW      51
	MOVWF      FARG_writeEEPROM_datas+0
	CALL       _writeEEPROM+0
;Securitas.c,111 :: 		writeEEPROM(4, '4');
	MOVLW      4
	MOVWF      FARG_writeEEPROM_address+0
	MOVLW      52
	MOVWF      FARG_writeEEPROM_datas+0
	CALL       _writeEEPROM+0
;Securitas.c,112 :: 		}
L_main41:
;Securitas.c,115 :: 		while (1){
L_main42:
;Securitas.c,116 :: 		mainMenuView();
	CALL       _mainMenuView+0
;Securitas.c,117 :: 		mainMenuInputHandler();
	CALL       _mainMenuInputHandler+0
;Securitas.c,118 :: 		}
	GOTO       L_main42
;Securitas.c,123 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_mainMenuView:

;Securitas.c,128 :: 		void mainMenuView(){
;Securitas.c,129 :: 		printToXY(1, 1, "Securitas!", 1);
	MOVLW      1
	MOVWF      FARG_printToXY_row+0
	MOVLW      0
	MOVWF      FARG_printToXY_row+1
	MOVLW      1
	MOVWF      FARG_printToXY_col+0
	MOVLW      0
	MOVWF      FARG_printToXY_col+1
	MOVLW      ?lstr1_Securitas+0
	MOVWF      FARG_printToXY_str+0
	MOVLW      1
	MOVWF      FARG_printToXY_flagClearScreen+0
	MOVLW      0
	MOVWF      FARG_printToXY_flagClearScreen+1
	CALL       _printToXY+0
;Securitas.c,130 :: 		printToXY(2, 2, "1.Open", 0);
	MOVLW      2
	MOVWF      FARG_printToXY_row+0
	MOVLW      0
	MOVWF      FARG_printToXY_row+1
	MOVLW      2
	MOVWF      FARG_printToXY_col+0
	MOVLW      0
	MOVWF      FARG_printToXY_col+1
	MOVLW      ?lstr2_Securitas+0
	MOVWF      FARG_printToXY_str+0
	CLRF       FARG_printToXY_flagClearScreen+0
	CLRF       FARG_printToXY_flagClearScreen+1
	CALL       _printToXY+0
;Securitas.c,131 :: 		printToXY(3, 2, "2.Cng", 0);
	MOVLW      3
	MOVWF      FARG_printToXY_row+0
	MOVLW      0
	MOVWF      FARG_printToXY_row+1
	MOVLW      2
	MOVWF      FARG_printToXY_col+0
	MOVLW      0
	MOVWF      FARG_printToXY_col+1
	MOVLW      ?lstr3_Securitas+0
	MOVWF      FARG_printToXY_str+0
	CLRF       FARG_printToXY_flagClearScreen+0
	CLRF       FARG_printToXY_flagClearScreen+1
	CALL       _printToXY+0
;Securitas.c,132 :: 		printToXY(4, 2, "3.Add", 0);
	MOVLW      4
	MOVWF      FARG_printToXY_row+0
	MOVLW      0
	MOVWF      FARG_printToXY_row+1
	MOVLW      2
	MOVWF      FARG_printToXY_col+0
	MOVLW      0
	MOVWF      FARG_printToXY_col+1
	MOVLW      ?lstr4_Securitas+0
	MOVWF      FARG_printToXY_str+0
	CLRF       FARG_printToXY_flagClearScreen+0
	CLRF       FARG_printToXY_flagClearScreen+1
	CALL       _printToXY+0
;Securitas.c,133 :: 		printToXY(5, 2, "4.Rmv", 0);
	MOVLW      5
	MOVWF      FARG_printToXY_row+0
	MOVLW      0
	MOVWF      FARG_printToXY_row+1
	MOVLW      2
	MOVWF      FARG_printToXY_col+0
	MOVLW      0
	MOVWF      FARG_printToXY_col+1
	MOVLW      ?lstr5_Securitas+0
	MOVWF      FARG_printToXY_str+0
	CLRF       FARG_printToXY_flagClearScreen+0
	CLRF       FARG_printToXY_flagClearScreen+1
	CALL       _printToXY+0
;Securitas.c,134 :: 		printToXY(6, 2, "5.Inf", 0);
	MOVLW      6
	MOVWF      FARG_printToXY_row+0
	MOVLW      0
	MOVWF      FARG_printToXY_row+1
	MOVLW      2
	MOVWF      FARG_printToXY_col+0
	MOVLW      0
	MOVWF      FARG_printToXY_col+1
	MOVLW      ?lstr6_Securitas+0
	MOVWF      FARG_printToXY_str+0
	CLRF       FARG_printToXY_flagClearScreen+0
	CLRF       FARG_printToXY_flagClearScreen+1
	CALL       _printToXY+0
;Securitas.c,135 :: 		delay_ms(500);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_mainMenuView44:
	DECFSZ     R13+0, 1
	GOTO       L_mainMenuView44
	DECFSZ     R12+0, 1
	GOTO       L_mainMenuView44
	DECFSZ     R11+0, 1
	GOTO       L_mainMenuView44
	NOP
	NOP
;Securitas.c,136 :: 		}
L_end_mainMenuView:
	RETURN
; end of _mainMenuView

_mainMenuInputHandler:

;Securitas.c,138 :: 		void mainMenuInputHandler()
;Securitas.c,140 :: 		keyPressed = keyPadKey();
	CALL       _keypadKey+0
	MOVF       R0+0, 0
	MOVWF      _keyPressed+0
;Securitas.c,142 :: 		switch (keyPressed)
	GOTO       L_mainMenuInputHandler45
;Securitas.c,144 :: 		case '1':
L_mainMenuInputHandler47:
;Securitas.c,145 :: 		openLockerView();
	CALL       _openLockerView+0
;Securitas.c,146 :: 		openLockerInputHandler();
	CALL       _openLockerInputHandler+0
;Securitas.c,147 :: 		break;
	GOTO       L_mainMenuInputHandler46
;Securitas.c,148 :: 		case '2':
L_mainMenuInputHandler48:
;Securitas.c,149 :: 		break;
	GOTO       L_mainMenuInputHandler46
;Securitas.c,150 :: 		case '3':
L_mainMenuInputHandler49:
;Securitas.c,151 :: 		break;
	GOTO       L_mainMenuInputHandler46
;Securitas.c,152 :: 		case '4':
L_mainMenuInputHandler50:
;Securitas.c,153 :: 		break;
	GOTO       L_mainMenuInputHandler46
;Securitas.c,154 :: 		case '5':
L_mainMenuInputHandler51:
;Securitas.c,155 :: 		aboutView();
	CALL       _aboutView+0
;Securitas.c,156 :: 		aboutViewInputHandler();
	CALL       _aboutViewInputHandler+0
;Securitas.c,157 :: 		break;
	GOTO       L_mainMenuInputHandler46
;Securitas.c,158 :: 		default:
L_mainMenuInputHandler52:
;Securitas.c,159 :: 		printToXY(1, 1, "Wrong!", 1);
	MOVLW      1
	MOVWF      FARG_printToXY_row+0
	MOVLW      0
	MOVWF      FARG_printToXY_row+1
	MOVLW      1
	MOVWF      FARG_printToXY_col+0
	MOVLW      0
	MOVWF      FARG_printToXY_col+1
	MOVLW      ?lstr7_Securitas+0
	MOVWF      FARG_printToXY_str+0
	MOVLW      1
	MOVWF      FARG_printToXY_flagClearScreen+0
	MOVLW      0
	MOVWF      FARG_printToXY_flagClearScreen+1
	CALL       _printToXY+0
;Securitas.c,160 :: 		delay_ms(2000);
	MOVLW      41
	MOVWF      R11+0
	MOVLW      150
	MOVWF      R12+0
	MOVLW      127
	MOVWF      R13+0
L_mainMenuInputHandler53:
	DECFSZ     R13+0, 1
	GOTO       L_mainMenuInputHandler53
	DECFSZ     R12+0, 1
	GOTO       L_mainMenuInputHandler53
	DECFSZ     R11+0, 1
	GOTO       L_mainMenuInputHandler53
;Securitas.c,161 :: 		break;
	GOTO       L_mainMenuInputHandler46
;Securitas.c,162 :: 		}
L_mainMenuInputHandler45:
	MOVF       _keyPressed+0, 0
	XORLW      49
	BTFSC      STATUS+0, 2
	GOTO       L_mainMenuInputHandler47
	MOVF       _keyPressed+0, 0
	XORLW      50
	BTFSC      STATUS+0, 2
	GOTO       L_mainMenuInputHandler48
	MOVF       _keyPressed+0, 0
	XORLW      51
	BTFSC      STATUS+0, 2
	GOTO       L_mainMenuInputHandler49
	MOVF       _keyPressed+0, 0
	XORLW      52
	BTFSC      STATUS+0, 2
	GOTO       L_mainMenuInputHandler50
	MOVF       _keyPressed+0, 0
	XORLW      53
	BTFSC      STATUS+0, 2
	GOTO       L_mainMenuInputHandler51
	GOTO       L_mainMenuInputHandler52
L_mainMenuInputHandler46:
;Securitas.c,163 :: 		}
L_end_mainMenuInputHandler:
	RETURN
; end of _mainMenuInputHandler

_openLockerView:

;Securitas.c,165 :: 		void openLockerView() {
;Securitas.c,166 :: 		printToXY(1, 1, "User:", 1);
	MOVLW      1
	MOVWF      FARG_printToXY_row+0
	MOVLW      0
	MOVWF      FARG_printToXY_row+1
	MOVLW      1
	MOVWF      FARG_printToXY_col+0
	MOVLW      0
	MOVWF      FARG_printToXY_col+1
	MOVLW      ?lstr8_Securitas+0
	MOVWF      FARG_printToXY_str+0
	MOVLW      1
	MOVWF      FARG_printToXY_flagClearScreen+0
	MOVLW      0
	MOVWF      FARG_printToXY_flagClearScreen+1
	CALL       _printToXY+0
;Securitas.c,167 :: 		printToXY(2, 2, "[A] [B] [C] [D]", 0);
	MOVLW      2
	MOVWF      FARG_printToXY_row+0
	MOVLW      0
	MOVWF      FARG_printToXY_row+1
	MOVLW      2
	MOVWF      FARG_printToXY_col+0
	MOVLW      0
	MOVWF      FARG_printToXY_col+1
	MOVLW      ?lstr9_Securitas+0
	MOVWF      FARG_printToXY_str+0
	CLRF       FARG_printToXY_flagClearScreen+0
	CLRF       FARG_printToXY_flagClearScreen+1
	CALL       _printToXY+0
;Securitas.c,168 :: 		}
L_end_openLockerView:
	RETURN
; end of _openLockerView

_openLockerInputHandler:

;Securitas.c,170 :: 		void openLockerInputHandler() {
;Securitas.c,171 :: 		keyPressed = keyPadKey();
	CALL       _keypadKey+0
	MOVF       R0+0, 0
	MOVWF      _keyPressed+0
;Securitas.c,178 :: 		userExists = isUserExistent(keyPressed);
	MOVF       R0+0, 0
	MOVWF      FARG_isUserExistent_user+0
	CALL       _isUserExistent+0
	MOVF       R0+0, 0
	MOVWF      _userExists+0
	MOVF       R0+1, 0
	MOVWF      _userExists+1
;Securitas.c,179 :: 		if(userExists){
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_openLockerInputHandler54
;Securitas.c,180 :: 		printToXY(1,1,"Enter Pin: ",1);
	MOVLW      1
	MOVWF      FARG_printToXY_row+0
	MOVLW      0
	MOVWF      FARG_printToXY_row+1
	MOVLW      1
	MOVWF      FARG_printToXY_col+0
	MOVLW      0
	MOVWF      FARG_printToXY_col+1
	MOVLW      ?lstr10_Securitas+0
	MOVWF      FARG_printToXY_str+0
	MOVLW      1
	MOVWF      FARG_printToXY_flagClearScreen+0
	MOVLW      0
	MOVWF      FARG_printToXY_flagClearScreen+1
	CALL       _printToXY+0
;Securitas.c,182 :: 		currentUser = keyPressed;
	MOVF       _keyPressed+0, 0
	MOVWF      _currentUser+0
;Securitas.c,184 :: 		keyPressed = keyPadKey();
	CALL       _keypadKey+0
	MOVF       R0+0, 0
	MOVWF      _keyPressed+0
;Securitas.c,185 :: 		delay_ms(400);
	MOVLW      9
	MOVWF      R11+0
	MOVLW      30
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_openLockerInputHandler55:
	DECFSZ     R13+0, 1
	GOTO       L_openLockerInputHandler55
	DECFSZ     R12+0, 1
	GOTO       L_openLockerInputHandler55
	DECFSZ     R11+0, 1
	GOTO       L_openLockerInputHandler55
	NOP
;Securitas.c,186 :: 		inputPinCode[3] = keyPressed;
	MOVF       _keyPressed+0, 0
	MOVWF      _inputPinCode+3
;Securitas.c,187 :: 		SSD1306_GotoXY( 2, 3);
	MOVLW      2
	MOVWF      FARG_SSD1306_GotoXY_x+0
	MOVLW      3
	MOVWF      FARG_SSD1306_GotoXY_y+0
	CALL       _SSD1306_GotoXY+0
;Securitas.c,188 :: 		SSD1306_PUTC(keyPressed);
	MOVF       _keyPressed+0, 0
	MOVWF      FARG_SSD1306_PutC_c+0
	CALL       _SSD1306_PutC+0
;Securitas.c,190 :: 		keyPressed = keyPadKey();
	CALL       _keypadKey+0
	MOVF       R0+0, 0
	MOVWF      _keyPressed+0
;Securitas.c,191 :: 		delay_ms(400);
	MOVLW      9
	MOVWF      R11+0
	MOVLW      30
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_openLockerInputHandler56:
	DECFSZ     R13+0, 1
	GOTO       L_openLockerInputHandler56
	DECFSZ     R12+0, 1
	GOTO       L_openLockerInputHandler56
	DECFSZ     R11+0, 1
	GOTO       L_openLockerInputHandler56
	NOP
;Securitas.c,192 :: 		inputPinCode[2] = keyPressed;
	MOVF       _keyPressed+0, 0
	MOVWF      _inputPinCode+2
;Securitas.c,193 :: 		SSD1306_GotoXY( 3, 3);
	MOVLW      3
	MOVWF      FARG_SSD1306_GotoXY_x+0
	MOVLW      3
	MOVWF      FARG_SSD1306_GotoXY_y+0
	CALL       _SSD1306_GotoXY+0
;Securitas.c,194 :: 		SSD1306_PUTC(keyPressed);
	MOVF       _keyPressed+0, 0
	MOVWF      FARG_SSD1306_PutC_c+0
	CALL       _SSD1306_PutC+0
;Securitas.c,196 :: 		keyPressed = keyPadKey();
	CALL       _keypadKey+0
	MOVF       R0+0, 0
	MOVWF      _keyPressed+0
;Securitas.c,197 :: 		delay_ms(400);
	MOVLW      9
	MOVWF      R11+0
	MOVLW      30
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_openLockerInputHandler57:
	DECFSZ     R13+0, 1
	GOTO       L_openLockerInputHandler57
	DECFSZ     R12+0, 1
	GOTO       L_openLockerInputHandler57
	DECFSZ     R11+0, 1
	GOTO       L_openLockerInputHandler57
	NOP
;Securitas.c,198 :: 		inputPinCode[1] = keyPressed;
	MOVF       _keyPressed+0, 0
	MOVWF      _inputPinCode+1
;Securitas.c,199 :: 		SSD1306_GotoXY( 4, 3);
	MOVLW      4
	MOVWF      FARG_SSD1306_GotoXY_x+0
	MOVLW      3
	MOVWF      FARG_SSD1306_GotoXY_y+0
	CALL       _SSD1306_GotoXY+0
;Securitas.c,200 :: 		SSD1306_PUTC(keyPressed);
	MOVF       _keyPressed+0, 0
	MOVWF      FARG_SSD1306_PutC_c+0
	CALL       _SSD1306_PutC+0
;Securitas.c,202 :: 		keyPressed = keyPadKey();
	CALL       _keypadKey+0
	MOVF       R0+0, 0
	MOVWF      _keyPressed+0
;Securitas.c,203 :: 		delay_ms(400);
	MOVLW      9
	MOVWF      R11+0
	MOVLW      30
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_openLockerInputHandler58:
	DECFSZ     R13+0, 1
	GOTO       L_openLockerInputHandler58
	DECFSZ     R12+0, 1
	GOTO       L_openLockerInputHandler58
	DECFSZ     R11+0, 1
	GOTO       L_openLockerInputHandler58
	NOP
;Securitas.c,204 :: 		inputPinCode[0] = keyPressed;
	MOVF       _keyPressed+0, 0
	MOVWF      _inputPinCode+0
;Securitas.c,205 :: 		SSD1306_GotoXY( 5, 3);
	MOVLW      5
	MOVWF      FARG_SSD1306_GotoXY_x+0
	MOVLW      3
	MOVWF      FARG_SSD1306_GotoXY_y+0
	CALL       _SSD1306_GotoXY+0
;Securitas.c,206 :: 		SSD1306_PUTC(keyPressed);
	MOVF       _keyPressed+0, 0
	MOVWF      FARG_SSD1306_PutC_c+0
	CALL       _SSD1306_PutC+0
;Securitas.c,208 :: 		getPinFromMemory(currentUser);
	MOVF       _currentUser+0, 0
	MOVWF      FARG_getPinFromMemory_user+0
	CALL       _getPinFromMemory+0
;Securitas.c,210 :: 		if(pinMatched()){
	CALL       _pinMatched+0
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_openLockerInputHandler59
;Securitas.c,211 :: 		rotate90Deg();
	CALL       _rotate90Deg+0
;Securitas.c,212 :: 		printToXY(1,1,"Lock Opened!",1);
	MOVLW      1
	MOVWF      FARG_printToXY_row+0
	MOVLW      0
	MOVWF      FARG_printToXY_row+1
	MOVLW      1
	MOVWF      FARG_printToXY_col+0
	MOVLW      0
	MOVWF      FARG_printToXY_col+1
	MOVLW      ?lstr11_Securitas+0
	MOVWF      FARG_printToXY_str+0
	MOVLW      1
	MOVWF      FARG_printToXY_flagClearScreen+0
	MOVLW      0
	MOVWF      FARG_printToXY_flagClearScreen+1
	CALL       _printToXY+0
;Securitas.c,213 :: 		keyPressed = keyPadKey();
	CALL       _keypadKey+0
	MOVF       R0+0, 0
	MOVWF      _keyPressed+0
;Securitas.c,214 :: 		rotate0Deg();
	CALL       _rotate0Deg+0
;Securitas.c,215 :: 		return;
	GOTO       L_end_openLockerInputHandler
;Securitas.c,216 :: 		}
L_openLockerInputHandler59:
;Securitas.c,218 :: 		printToXY(1,1,"Wrong Pin!",1);
	MOVLW      1
	MOVWF      FARG_printToXY_row+0
	MOVLW      0
	MOVWF      FARG_printToXY_row+1
	MOVLW      1
	MOVWF      FARG_printToXY_col+0
	MOVLW      0
	MOVWF      FARG_printToXY_col+1
	MOVLW      ?lstr12_Securitas+0
	MOVWF      FARG_printToXY_str+0
	MOVLW      1
	MOVWF      FARG_printToXY_flagClearScreen+0
	MOVLW      0
	MOVWF      FARG_printToXY_flagClearScreen+1
	CALL       _printToXY+0
;Securitas.c,219 :: 		delay_ms(1500);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_openLockerInputHandler61:
	DECFSZ     R13+0, 1
	GOTO       L_openLockerInputHandler61
	DECFSZ     R12+0, 1
	GOTO       L_openLockerInputHandler61
	DECFSZ     R11+0, 1
	GOTO       L_openLockerInputHandler61
	NOP
;Securitas.c,220 :: 		return;
	GOTO       L_end_openLockerInputHandler
;Securitas.c,224 :: 		}
L_openLockerInputHandler54:
;Securitas.c,226 :: 		printToXY(1,1,"Intruder!",1);
	MOVLW      1
	MOVWF      FARG_printToXY_row+0
	MOVLW      0
	MOVWF      FARG_printToXY_row+1
	MOVLW      1
	MOVWF      FARG_printToXY_col+0
	MOVLW      0
	MOVWF      FARG_printToXY_col+1
	MOVLW      ?lstr13_Securitas+0
	MOVWF      FARG_printToXY_str+0
	MOVLW      1
	MOVWF      FARG_printToXY_flagClearScreen+0
	MOVLW      0
	MOVWF      FARG_printToXY_flagClearScreen+1
	CALL       _printToXY+0
;Securitas.c,227 :: 		delay_ms(1500);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_openLockerInputHandler63:
	DECFSZ     R13+0, 1
	GOTO       L_openLockerInputHandler63
	DECFSZ     R12+0, 1
	GOTO       L_openLockerInputHandler63
	DECFSZ     R11+0, 1
	GOTO       L_openLockerInputHandler63
	NOP
;Securitas.c,229 :: 		}
L_end_openLockerInputHandler:
	RETURN
; end of _openLockerInputHandler

_changePinView:

;Securitas.c,231 :: 		void changePinView()
;Securitas.c,233 :: 		}
L_end_changePinView:
	RETURN
; end of _changePinView

_changePinInputHandler:

;Securitas.c,234 :: 		void changePinInputHandler() {}
L_end_changePinInputHandler:
	RETURN
; end of _changePinInputHandler

_addUserView:

;Securitas.c,236 :: 		void addUserView() {}
L_end_addUserView:
	RETURN
; end of _addUserView

_addUserViewInputHandler:

;Securitas.c,237 :: 		void addUserViewInputHandler() {}
L_end_addUserViewInputHandler:
	RETURN
; end of _addUserViewInputHandler

_removeUserView:

;Securitas.c,239 :: 		void removeUserView() {}
L_end_removeUserView:
	RETURN
; end of _removeUserView

_removeUserInputHandler:

;Securitas.c,240 :: 		void removeUserInputHandler() {}
L_end_removeUserInputHandler:
	RETURN
; end of _removeUserInputHandler

_aboutView:

;Securitas.c,242 :: 		void aboutView()
;Securitas.c,249 :: 		}
L_end_aboutView:
	RETURN
; end of _aboutView

_aboutViewInputHandler:

;Securitas.c,251 :: 		void aboutViewInputHandler()
;Securitas.c,253 :: 		keyPressed = keyPadKey();
	CALL       _keypadKey+0
	MOVF       R0+0, 0
	MOVWF      _keyPressed+0
;Securitas.c,254 :: 		}
L_end_aboutViewInputHandler:
	RETURN
; end of _aboutViewInputHandler

_keypadKey:

;Securitas.c,256 :: 		unsigned char keypadKey()
;Securitas.c,262 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;Securitas.c,264 :: 		while (1)
L_keypadKey64:
;Securitas.c,266 :: 		R1 = 1;
	BSF        RD0_bit+0, BitPos(RD0_bit+0)
;Securitas.c,267 :: 		R2 = R3 = R4 = 0;
	BCF        RD3_bit+0, BitPos(RD3_bit+0)
	BTFSC      RD3_bit+0, BitPos(RD3_bit+0)
	GOTO       L__keypadKey159
	BCF        RD2_bit+0, BitPos(RD2_bit+0)
	GOTO       L__keypadKey160
L__keypadKey159:
	BSF        RD2_bit+0, BitPos(RD2_bit+0)
L__keypadKey160:
	BTFSC      RD2_bit+0, BitPos(RD2_bit+0)
	GOTO       L__keypadKey161
	BCF        RD1_bit+0, BitPos(RD1_bit+0)
	GOTO       L__keypadKey162
L__keypadKey161:
	BSF        RD1_bit+0, BitPos(RD1_bit+0)
L__keypadKey162:
;Securitas.c,268 :: 		SSD1306_GotoXY(1, 1);
	MOVLW      1
	MOVWF      FARG_SSD1306_GotoXY_x+0
	MOVLW      1
	MOVWF      FARG_SSD1306_GotoXY_y+0
	CALL       _SSD1306_GotoXY+0
;Securitas.c,269 :: 		if (C1 || C2 || C3 || C4)
	BTFSC      RD4_bit+0, BitPos(RD4_bit+0)
	GOTO       L__keypadKey125
	BTFSC      RD5_bit+0, BitPos(RD5_bit+0)
	GOTO       L__keypadKey125
	BTFSC      RD6_bit+0, BitPos(RD6_bit+0)
	GOTO       L__keypadKey125
	BTFSC      RD7_bit+0, BitPos(RD7_bit+0)
	GOTO       L__keypadKey125
	GOTO       L_keypadKey68
L__keypadKey125:
;Securitas.c,271 :: 		keypadRow = 0;
	CLRF       _keypadRow+0
;Securitas.c,272 :: 		break;
	GOTO       L_keypadKey65
;Securitas.c,273 :: 		}
L_keypadKey68:
;Securitas.c,274 :: 		R2 = 1;
	BSF        RD1_bit+0, BitPos(RD1_bit+0)
;Securitas.c,275 :: 		R1 = 0;
	BCF        RD0_bit+0, BitPos(RD0_bit+0)
;Securitas.c,276 :: 		if (C1 || C2 || C3 || C4)
	BTFSC      RD4_bit+0, BitPos(RD4_bit+0)
	GOTO       L__keypadKey124
	BTFSC      RD5_bit+0, BitPos(RD5_bit+0)
	GOTO       L__keypadKey124
	BTFSC      RD6_bit+0, BitPos(RD6_bit+0)
	GOTO       L__keypadKey124
	BTFSC      RD7_bit+0, BitPos(RD7_bit+0)
	GOTO       L__keypadKey124
	GOTO       L_keypadKey71
L__keypadKey124:
;Securitas.c,278 :: 		keypadRow = 1;
	MOVLW      1
	MOVWF      _keypadRow+0
;Securitas.c,279 :: 		break;
	GOTO       L_keypadKey65
;Securitas.c,280 :: 		}
L_keypadKey71:
;Securitas.c,281 :: 		R3 = 1;
	BSF        RD2_bit+0, BitPos(RD2_bit+0)
;Securitas.c,282 :: 		R2 = 0;
	BCF        RD1_bit+0, BitPos(RD1_bit+0)
;Securitas.c,283 :: 		if (C1 || C2 || C3 || C4)
	BTFSC      RD4_bit+0, BitPos(RD4_bit+0)
	GOTO       L__keypadKey123
	BTFSC      RD5_bit+0, BitPos(RD5_bit+0)
	GOTO       L__keypadKey123
	BTFSC      RD6_bit+0, BitPos(RD6_bit+0)
	GOTO       L__keypadKey123
	BTFSC      RD7_bit+0, BitPos(RD7_bit+0)
	GOTO       L__keypadKey123
	GOTO       L_keypadKey74
L__keypadKey123:
;Securitas.c,285 :: 		keypadRow = 2;
	MOVLW      2
	MOVWF      _keypadRow+0
;Securitas.c,286 :: 		break;
	GOTO       L_keypadKey65
;Securitas.c,287 :: 		}
L_keypadKey74:
;Securitas.c,288 :: 		R4 = 1;
	BSF        RD3_bit+0, BitPos(RD3_bit+0)
;Securitas.c,289 :: 		R3 = 0;
	BCF        RD2_bit+0, BitPos(RD2_bit+0)
;Securitas.c,290 :: 		if (C1 || C2 || C3 || C4)
	BTFSC      RD4_bit+0, BitPos(RD4_bit+0)
	GOTO       L__keypadKey122
	BTFSC      RD5_bit+0, BitPos(RD5_bit+0)
	GOTO       L__keypadKey122
	BTFSC      RD6_bit+0, BitPos(RD6_bit+0)
	GOTO       L__keypadKey122
	BTFSC      RD7_bit+0, BitPos(RD7_bit+0)
	GOTO       L__keypadKey122
	GOTO       L_keypadKey77
L__keypadKey122:
;Securitas.c,292 :: 		keypadRow = 3;
	MOVLW      3
	MOVWF      _keypadRow+0
;Securitas.c,293 :: 		break;
	GOTO       L_keypadKey65
;Securitas.c,294 :: 		}
L_keypadKey77:
;Securitas.c,295 :: 		}
	GOTO       L_keypadKey64
L_keypadKey65:
;Securitas.c,297 :: 		if (C1 == 1)
	BTFSS      RD4_bit+0, BitPos(RD4_bit+0)
	GOTO       L_keypadKey78
;Securitas.c,299 :: 		keypadColumn = 0;
	CLRF       _keypadColumn+0
;Securitas.c,300 :: 		}
	GOTO       L_keypadKey79
L_keypadKey78:
;Securitas.c,301 :: 		else if (C2 == 1)
	BTFSS      RD5_bit+0, BitPos(RD5_bit+0)
	GOTO       L_keypadKey80
;Securitas.c,303 :: 		keypadColumn = 1;
	MOVLW      1
	MOVWF      _keypadColumn+0
;Securitas.c,304 :: 		}
	GOTO       L_keypadKey81
L_keypadKey80:
;Securitas.c,305 :: 		else if (C3 == 1)
	BTFSS      RD6_bit+0, BitPos(RD6_bit+0)
	GOTO       L_keypadKey82
;Securitas.c,307 :: 		keypadColumn = 2;
	MOVLW      2
	MOVWF      _keypadColumn+0
;Securitas.c,308 :: 		}
	GOTO       L_keypadKey83
L_keypadKey82:
;Securitas.c,309 :: 		else if (C4 == 1)
	BTFSS      RD7_bit+0, BitPos(RD7_bit+0)
	GOTO       L_keypadKey84
;Securitas.c,311 :: 		keypadColumn = 3;
	MOVLW      3
	MOVWF      _keypadColumn+0
;Securitas.c,312 :: 		}
L_keypadKey84:
L_keypadKey83:
L_keypadKey81:
L_keypadKey79:
;Securitas.c,314 :: 		return (KEY_ARRAY[keypadRow][keypadColumn]);
	MOVF       _keypadRow+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      _KEY_ARRAY+0
	ADDWF      R0+0, 1
	MOVF       _keypadColumn+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
;Securitas.c,315 :: 		}
L_end_keypadKey:
	RETURN
; end of _keypadKey

_printToXY:

;Securitas.c,317 :: 		void printToXY(int row, int col, char *str, int flagClearScreen)
;Securitas.c,319 :: 		if (flagClearScreen)
	MOVF       FARG_printToXY_flagClearScreen+0, 0
	IORWF      FARG_printToXY_flagClearScreen+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_printToXY85
;Securitas.c,321 :: 		SSD1306_ClearDisplay();
	CALL       _SSD1306_ClearDisplay+0
;Securitas.c,322 :: 		}
L_printToXY85:
;Securitas.c,323 :: 		SSD1306_GotoXY(col, row); // move cursor to column col, row row
	MOVF       FARG_printToXY_col+0, 0
	MOVWF      FARG_SSD1306_GotoXY_x+0
	MOVF       FARG_printToXY_row+0, 0
	MOVWF      FARG_SSD1306_GotoXY_y+0
	CALL       _SSD1306_GotoXY+0
;Securitas.c,324 :: 		SSD1306_Print(str);       // print text
	MOVF       FARG_printToXY_str+0, 0
	MOVWF      FARG_SSD1306_Print_s+0
	CALL       _SSD1306_Print+0
;Securitas.c,325 :: 		}
L_end_printToXY:
	RETURN
; end of _printToXY

_readEEPROM:

;Securitas.c,327 :: 		unsigned char readEEPROM(unsigned char address)
;Securitas.c,329 :: 		EEADR = address; //Address to be read
	MOVF       FARG_readEEPROM_address+0, 0
	MOVWF      EEADR+0
;Securitas.c,330 :: 		EECON1.EEPGD = 0;//Selecting EEPROM Data Memory
	BCF        EECON1+0, 7
;Securitas.c,331 :: 		EECON1.RD = 1; //Initialise read cycle
	BSF        EECON1+0, 0
;Securitas.c,332 :: 		return EEDATA; //Returning data
	MOVF       EEDATA+0, 0
	MOVWF      R0+0
;Securitas.c,333 :: 		}
L_end_readEEPROM:
	RETURN
; end of _readEEPROM

_writeEEPROM:

;Securitas.c,335 :: 		void writeEEPROM(unsigned char address, unsigned char datas)
;Securitas.c,338 :: 		EEADR = address; //Address to write
	MOVF       FARG_writeEEPROM_address+0, 0
	MOVWF      EEADR+0
;Securitas.c,339 :: 		EEDATA = datas; //Data to write
	MOVF       FARG_writeEEPROM_datas+0, 0
	MOVWF      EEDATA+0
;Securitas.c,340 :: 		EECON1.EEPGD = 0; //Selecting EEPROM Data Memory
	BCF        EECON1+0, 7
;Securitas.c,341 :: 		EECON1.WREN = 1; //Enable writing of EEPROM
	BSF        EECON1+0, 2
;Securitas.c,342 :: 		INTCON_SAVE=INTCON;//Backup INCON interupt register
	MOVF       INTCON+0, 0
	MOVWF      R0+0
;Securitas.c,343 :: 		INTCON=0; //Diables the interrupt
	CLRF       INTCON+0
;Securitas.c,344 :: 		EECON2=0x55; //Required sequence for write to internal EEPROM
	MOVLW      85
	MOVWF      EECON2+0
;Securitas.c,345 :: 		EECON2=0xAA; //Required sequence for write to internal EEPROM
	MOVLW      170
	MOVWF      EECON2+0
;Securitas.c,346 :: 		EECON1.WR = 1; //Initialise write cycle
	BSF        EECON1+0, 1
;Securitas.c,347 :: 		INTCON = INTCON_SAVE;//Enables Interrupt
	MOVF       R0+0, 0
	MOVWF      INTCON+0
;Securitas.c,348 :: 		EECON1.WREN = 0; //To disable write
	BCF        EECON1+0, 2
;Securitas.c,349 :: 		while(PIR2.EEIF == 0)//Checking for complition of write operation
L_writeEEPROM86:
	BTFSC      PIR2+0, 4
	GOTO       L_writeEEPROM87
;Securitas.c,350 :: 		{  }
	GOTO       L_writeEEPROM86
L_writeEEPROM87:
;Securitas.c,351 :: 		PIR2.EEIF = 0; //Clearing EEIF bit
	BCF        PIR2+0, 4
;Securitas.c,352 :: 		}
L_end_writeEEPROM:
	RETURN
; end of _writeEEPROM

_getUserNumber:

;Securitas.c,354 :: 		int getUserNumber(char user){
;Securitas.c,356 :: 		switch(user){
	GOTO       L_getUserNumber88
;Securitas.c,357 :: 		case 'A':
L_getUserNumber90:
;Securitas.c,358 :: 		userNum = 0;
	CLRF       R2+0
	CLRF       R2+1
;Securitas.c,359 :: 		break;
	GOTO       L_getUserNumber89
;Securitas.c,360 :: 		case 'B':
L_getUserNumber91:
;Securitas.c,361 :: 		userNum = 1;
	MOVLW      1
	MOVWF      R2+0
	MOVLW      0
	MOVWF      R2+1
;Securitas.c,362 :: 		break;
	GOTO       L_getUserNumber89
;Securitas.c,363 :: 		case 'C':
L_getUserNumber92:
;Securitas.c,364 :: 		userNum = 2;
	MOVLW      2
	MOVWF      R2+0
	MOVLW      0
	MOVWF      R2+1
;Securitas.c,365 :: 		break;
	GOTO       L_getUserNumber89
;Securitas.c,366 :: 		case 'D':
L_getUserNumber93:
;Securitas.c,367 :: 		userNum = 3;
	MOVLW      3
	MOVWF      R2+0
	MOVLW      0
	MOVWF      R2+1
;Securitas.c,368 :: 		break;
	GOTO       L_getUserNumber89
;Securitas.c,369 :: 		}
L_getUserNumber88:
	MOVF       FARG_getUserNumber_user+0, 0
	XORLW      65
	BTFSC      STATUS+0, 2
	GOTO       L_getUserNumber90
	MOVF       FARG_getUserNumber_user+0, 0
	XORLW      66
	BTFSC      STATUS+0, 2
	GOTO       L_getUserNumber91
	MOVF       FARG_getUserNumber_user+0, 0
	XORLW      67
	BTFSC      STATUS+0, 2
	GOTO       L_getUserNumber92
	MOVF       FARG_getUserNumber_user+0, 0
	XORLW      68
	BTFSC      STATUS+0, 2
	GOTO       L_getUserNumber93
L_getUserNumber89:
;Securitas.c,370 :: 		return userNum;
	MOVF       R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	MOVWF      R0+1
;Securitas.c,371 :: 		}
L_end_getUserNumber:
	RETURN
; end of _getUserNumber

_isUserExistent:

;Securitas.c,373 :: 		int isUserExistent(char user){
;Securitas.c,375 :: 		switch(user){
	GOTO       L_isUserExistent94
;Securitas.c,376 :: 		case 'A':
L_isUserExistent96:
;Securitas.c,377 :: 		userNum = 0;
	CLRF       isUserExistent_userNum_L0+0
	CLRF       isUserExistent_userNum_L0+1
;Securitas.c,378 :: 		break;
	GOTO       L_isUserExistent95
;Securitas.c,379 :: 		case 'B':
L_isUserExistent97:
;Securitas.c,380 :: 		userNum = 1;
	MOVLW      1
	MOVWF      isUserExistent_userNum_L0+0
	MOVLW      0
	MOVWF      isUserExistent_userNum_L0+1
;Securitas.c,381 :: 		break;
	GOTO       L_isUserExistent95
;Securitas.c,382 :: 		case 'C':
L_isUserExistent98:
;Securitas.c,383 :: 		userNum = 2;
	MOVLW      2
	MOVWF      isUserExistent_userNum_L0+0
	MOVLW      0
	MOVWF      isUserExistent_userNum_L0+1
;Securitas.c,384 :: 		break;
	GOTO       L_isUserExistent95
;Securitas.c,385 :: 		case 'D':
L_isUserExistent99:
;Securitas.c,386 :: 		userNum = 3;
	MOVLW      3
	MOVWF      isUserExistent_userNum_L0+0
	MOVLW      0
	MOVWF      isUserExistent_userNum_L0+1
;Securitas.c,387 :: 		break;
	GOTO       L_isUserExistent95
;Securitas.c,388 :: 		default:
L_isUserExistent100:
;Securitas.c,389 :: 		return  0;
	CLRF       R0+0
	CLRF       R0+1
	GOTO       L_end_isUserExistent
;Securitas.c,390 :: 		}
L_isUserExistent94:
	MOVF       FARG_isUserExistent_user+0, 0
	XORLW      65
	BTFSC      STATUS+0, 2
	GOTO       L_isUserExistent96
	MOVF       FARG_isUserExistent_user+0, 0
	XORLW      66
	BTFSC      STATUS+0, 2
	GOTO       L_isUserExistent97
	MOVF       FARG_isUserExistent_user+0, 0
	XORLW      67
	BTFSC      STATUS+0, 2
	GOTO       L_isUserExistent98
	MOVF       FARG_isUserExistent_user+0, 0
	XORLW      68
	BTFSC      STATUS+0, 2
	GOTO       L_isUserExistent99
	GOTO       L_isUserExistent100
L_isUserExistent95:
;Securitas.c,391 :: 		userExists =  readEEPROM(5*userNum);
	MOVLW      5
	MOVWF      R0+0
	MOVF       isUserExistent_userNum_L0+0, 0
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_readEEPROM_address+0
	CALL       _readEEPROM+0
	MOVF       R0+0, 0
	MOVWF      _userExists+0
	CLRF       _userExists+1
;Securitas.c,393 :: 		if(userExists == 1){
	MOVLW      0
	XORWF      _userExists+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__isUserExistent168
	MOVLW      1
	XORWF      _userExists+0, 0
L__isUserExistent168:
	BTFSS      STATUS+0, 2
	GOTO       L_isUserExistent101
;Securitas.c,394 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	GOTO       L_end_isUserExistent
;Securitas.c,395 :: 		}
L_isUserExistent101:
;Securitas.c,397 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
;Securitas.c,399 :: 		}
L_end_isUserExistent:
	RETURN
; end of _isUserExistent

_rotate0Deg:

;Securitas.c,401 :: 		void rotate0Deg(){
;Securitas.c,402 :: 		for(i=0;i<50;i++)
	CLRF       _i+0
	CLRF       _i+1
L_rotate0Deg103:
	MOVLW      0
	SUBWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotate0Deg170
	MOVLW      50
	SUBWF      _i+0, 0
L__rotate0Deg170:
	BTFSC      STATUS+0, 0
	GOTO       L_rotate0Deg104
;Securitas.c,404 :: 		PORTB.F0 = 1;
	BSF        PORTB+0, 0
;Securitas.c,405 :: 		delay_us(1499); // pulse of 800us
	MOVLW      8
	MOVWF      R12+0
	MOVLW      200
	MOVWF      R13+0
L_rotate0Deg106:
	DECFSZ     R13+0, 1
	GOTO       L_rotate0Deg106
	DECFSZ     R12+0, 1
	GOTO       L_rotate0Deg106
	NOP
;Securitas.c,406 :: 		PORTB.F0 = 0;
	BCF        PORTB+0, 0
;Securitas.c,407 :: 		delay_us(18501);
	MOVLW      97
	MOVWF      R12+0
	MOVLW      26
	MOVWF      R13+0
L_rotate0Deg107:
	DECFSZ     R13+0, 1
	GOTO       L_rotate0Deg107
	DECFSZ     R12+0, 1
	GOTO       L_rotate0Deg107
	NOP
;Securitas.c,402 :: 		for(i=0;i<50;i++)
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Securitas.c,408 :: 		}
	GOTO       L_rotate0Deg103
L_rotate0Deg104:
;Securitas.c,409 :: 		}
L_end_rotate0Deg:
	RETURN
; end of _rotate0Deg

_rotate90Deg:

;Securitas.c,411 :: 		void rotate90Deg(){
;Securitas.c,412 :: 		for(i=0;i<50;i++)
	CLRF       _i+0
	CLRF       _i+1
L_rotate90Deg108:
	MOVLW      0
	SUBWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__rotate90Deg172
	MOVLW      50
	SUBWF      _i+0, 0
L__rotate90Deg172:
	BTFSC      STATUS+0, 0
	GOTO       L_rotate90Deg109
;Securitas.c,414 :: 		PORTB.F0 = 1;
	BSF        PORTB+0, 0
;Securitas.c,415 :: 		delay_us(2100); // pulse of 800us
	MOVLW      11
	MOVWF      R12+0
	MOVLW      231
	MOVWF      R13+0
L_rotate90Deg111:
	DECFSZ     R13+0, 1
	GOTO       L_rotate90Deg111
	DECFSZ     R12+0, 1
	GOTO       L_rotate90Deg111
	NOP
	NOP
;Securitas.c,416 :: 		PORTB.F0 = 0;
	BCF        PORTB+0, 0
;Securitas.c,417 :: 		delay_us(17900);
	MOVLW      93
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_rotate90Deg112:
	DECFSZ     R13+0, 1
	GOTO       L_rotate90Deg112
	DECFSZ     R12+0, 1
	GOTO       L_rotate90Deg112
	NOP
	NOP
;Securitas.c,412 :: 		for(i=0;i<50;i++)
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Securitas.c,418 :: 		}
	GOTO       L_rotate90Deg108
L_rotate90Deg109:
;Securitas.c,419 :: 		}
L_end_rotate90Deg:
	RETURN
; end of _rotate90Deg

_pinMatched:

;Securitas.c,421 :: 		int pinMatched(){
;Securitas.c,422 :: 		for(i=0; i<4; i++){
	CLRF       _i+0
	CLRF       _i+1
L_pinMatched113:
	MOVLW      0
	SUBWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__pinMatched174
	MOVLW      4
	SUBWF      _i+0, 0
L__pinMatched174:
	BTFSC      STATUS+0, 0
	GOTO       L_pinMatched114
;Securitas.c,423 :: 		if(inputPinCode[i] != memoryPinCode[i]){
	MOVF       _i+0, 0
	ADDLW      _inputPinCode+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       _i+0, 0
	ADDLW      _memoryPinCode+0
	MOVWF      FSR
	MOVF       R1+0, 0
	XORWF      INDF+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_pinMatched116
;Securitas.c,424 :: 		return 0;
	CLRF       R0+0
	CLRF       R0+1
	GOTO       L_end_pinMatched
;Securitas.c,425 :: 		}
L_pinMatched116:
;Securitas.c,422 :: 		for(i=0; i<4; i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;Securitas.c,426 :: 		}
	GOTO       L_pinMatched113
L_pinMatched114:
;Securitas.c,427 :: 		delay_ms(5000);
	MOVLW      102
	MOVWF      R11+0
	MOVLW      118
	MOVWF      R12+0
	MOVLW      193
	MOVWF      R13+0
L_pinMatched117:
	DECFSZ     R13+0, 1
	GOTO       L_pinMatched117
	DECFSZ     R12+0, 1
	GOTO       L_pinMatched117
	DECFSZ     R11+0, 1
	GOTO       L_pinMatched117
;Securitas.c,428 :: 		return 1;
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
;Securitas.c,429 :: 		}
L_end_pinMatched:
	RETURN
; end of _pinMatched

_getPinFromMemory:

;Securitas.c,431 :: 		void getPinFromMemory(char user){
;Securitas.c,433 :: 		userNumber = getUserNumber(user);
	MOVF       FARG_getPinFromMemory_user+0, 0
	MOVWF      FARG_getUserNumber_user+0
	CALL       _getUserNumber+0
	MOVF       R0+0, 0
	MOVWF      getPinFromMemory_userNumber_L0+0
	MOVF       R0+1, 0
	MOVWF      getPinFromMemory_userNumber_L0+1
;Securitas.c,435 :: 		SSD1306_GotoXY( i+1, 6);
	INCF       _i+0, 0
	MOVWF      FARG_SSD1306_GotoXY_x+0
	MOVLW      6
	MOVWF      FARG_SSD1306_GotoXY_y+0
	CALL       _SSD1306_GotoXY+0
;Securitas.c,436 :: 		SSD1306_PUTC(usernumber+48);
	MOVLW      48
	ADDWF      getPinFromMemory_userNumber_L0+0, 0
	MOVWF      FARG_SSD1306_PutC_c+0
	CALL       _SSD1306_PutC+0
;Securitas.c,437 :: 		memoryPinCode[3] = readEEPROM(userNumber*5+1);
	MOVF       getPinFromMemory_userNumber_L0+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	INCF       R0+0, 0
	MOVWF      FARG_readEEPROM_address+0
	CALL       _readEEPROM+0
	MOVF       R0+0, 0
	MOVWF      _memoryPinCode+3
;Securitas.c,438 :: 		memoryPinCode[2] = readEEPROM(userNumber*5+2);
	MOVF       getPinFromMemory_userNumber_L0+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVLW      2
	ADDWF      R0+0, 0
	MOVWF      FARG_readEEPROM_address+0
	CALL       _readEEPROM+0
	MOVF       R0+0, 0
	MOVWF      _memoryPinCode+2
;Securitas.c,439 :: 		memoryPinCode[1] = readEEPROM(userNumber*5+3);
	MOVF       getPinFromMemory_userNumber_L0+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVLW      3
	ADDWF      R0+0, 0
	MOVWF      FARG_readEEPROM_address+0
	CALL       _readEEPROM+0
	MOVF       R0+0, 0
	MOVWF      _memoryPinCode+1
;Securitas.c,440 :: 		memoryPinCode[0] = readEEPROM(userNumber*5+4);
	MOVF       getPinFromMemory_userNumber_L0+0, 0
	MOVWF      R0+0
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVLW      4
	ADDWF      R0+0, 0
	MOVWF      FARG_readEEPROM_address+0
	CALL       _readEEPROM+0
	MOVF       R0+0, 0
	MOVWF      _memoryPinCode+0
;Securitas.c,442 :: 		}
L_end_getPinFromMemory:
	RETURN
; end of _getPinFromMemory
