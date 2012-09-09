;---------------------------------------------------------------------
; CUSTOM PAGE to DOWNLOAD REQUIRED DEPENDENCIES
; - Modified from ASCEND NSIS installer (http://www.ascend4.org/)

Var CHECKPY
Var CHECKMUTAGEN
;Var CHECKPYGTK
;Var CHECKGST
;Var CHECKGSTSDK
Var CHECKGSTCOMSDK

!macro setCheckboxChecked CB
	SendMessage ${CB} ${BM_SETCHECK} 0x0001 0
	Pop $0
!macroend

Function dependenciesCreate
	
	${If} $HAVE_PYTHON == 'OK'
	${AndIf} $HAVE_MUTAGEN == 'OK'
	;${AndIf} $HAVE_PYGTK == 'OK'
	;${AndIf} $HAVE_GST == 'OK'
	;${AndIf} $HAVE_GSTSDK == 'OK'
    ${AndIf} $HAVE_GSTCOMSDK == 'OK'
		; do nothing in this page
	${Else}
		nsDialogs::Create /NOUNLOAD 1018
		Pop $0

		${NSD_CreateLabel} 0% 0 100% 48% "The following additional packages are required for Exaile to function correctly. Checked items will be downloaded and installed (some of the installers may require you to click 'next' a few times). If you already have the components installed you can unckeck them and they will not be downloaded. If any of these packages are not installed, Exaile will not work."
		Pop $0

		${If} $HAVE_PYTHON == 'NOK'
			${NSD_CreateCheckbox} 10% 48% 100% 8u "Python ${PYTHON_VERSION} (${PYTHON_FSIZE})"
			Pop $CHECKPY
			!insertmacro setCheckboxChecked $CHECKPY
        ${Else}
            ${NSD_CreateLabel} 10% 48% 100% 8u "--- Python ${PYTHON_VERSION} already installed"
		${EndIf}
        
        ${If} $HAVE_MUTAGEN == 'NOK'
			${NSD_CreateCheckbox} 10% 56% 100% 8u "Mutagen ${MUTAGEN_VERSION} (${MUTAGEN_FSIZE})"
			Pop $CHECKMUTAGEN
			!insertmacro setCheckboxChecked $CHECKMUTAGEN
        ${Else}
            ${NSD_CreateLabel} 10% 56% 100% 8u "--- Mutagen already installed"
		${EndIf}
        
        ; GStreamer.com SDK
        
        ${If} $HAVE_GSTCOMSDK == 'NOK'
			${NSD_CreateCheckbox} 10% 64% 100% 8u "GStreamer.com SDK ${GSTCOMSDK_VERSION} (${GSTCOMSDK_FSIZE})"
			Pop $CHECKGSTCOMSDK
			!insertmacro setCheckboxChecked $CHECKGSTCOMSDK
        ${Else}
            ${NSD_CreateLabel} 10% 64% 100% 8u "--- GStreamer.com SDK already installed"
		${EndIf}
        
        ; PyGTK - only needed for OSSBuild install
        
        ;${If} $HAVE_PYGTK == 'NOK'
		;	${NSD_CreateCheckbox} 10% 64% 100% 8u "PyGTK ${PYGTK_VERSION} All-in-one installer (${PYGTK_FSIZE})"
		;	Pop $CHECKPYGTK
		;	!insertmacro setCheckboxChecked $CHECKPYGTK
        ;${Else}
        ;    ${NSD_CreateLabel} 10% 64% 100% 8u "--- PyGTK already installed"
		;${EndIf}
		
        ; GStreamer OSSBuild 
        
        ;${If} $HAVE_GST == 'NOK'
		;	${NSD_CreateCheckbox} 10% 72% 100% 8u "GStreamer OSSBuild ${GST_VERSION} (${GST_FSIZE})"
		;	Pop $CHECKGST
		;	!insertmacro setCheckboxChecked $CHECKGST
        ;${Else}
        ;    ${NSD_CreateLabel} 10% 72% 100% 8u "--- GStreamer OSSBuild already installed"
		;${EndIf}
        ;
		;${If} $HAVE_GSTSDK == 'NOK'
		;	${NSD_CreateCheckbox} 10% 80% 100% 8u "GStreamer OSSBuild ${GSTSDK_VERSION} SDK w/PyGST (${GSTSDK_FSIZE}, requires .NET Framework)"
		;	Pop $CHECKGSTSDK
		;	!insertmacro setCheckboxChecked $CHECKGSTSDK
        ;${Else}
        ;    ${NSD_CreateLabel} 10% 80% 100% 8u "--- GStreamer OSSBuild SDK already installed"
		;${EndIf}
        
		nsDialogs::Show
	${EndIf}
	
FunctionEnd

Function DependenciesLeave
	SendMessage $CHECKPY        ${BM_GETCHECK} 0 0 $NEED_PYTHON
	SendMessage $CHECKMUTAGEN   ${BM_GETCHECK} 0 0 $NEED_MUTAGEN
    ;SendMessage $CHECKPYGTK     ${BM_GETCHECK} 0 0 $NEED_PYGTK
    ;SendMessage $CHECKGST       ${BM_GETCHECK} 0 0 $NEED_GST
	;SendMessage $CHECKGSTSDK    ${BM_GETCHECK} 0 0 $NEED_GSTSDK
	SendMessage $CHECKGSTCOMSDK ${BM_GETCHECK} 0 0 $NEED_GSTCOMSDK
FunctionEnd
	