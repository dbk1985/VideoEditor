/*
 File: color.fsh
 Abstract: A fragment shader that draws points with assigned color and 
 texture.
 Version: 1.13
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 
 */

precision highp float;

uniform sampler2D texture;
varying lowp vec4 color;

#define Max(a, b) (a > b ? a : b)
#define Min(a, b) (a < b ? a : b)

float hue2rgb(float p, float q, float t) {
    if(t < 0.0) t += 1.0;
    if(t > 1.0) t -= 1.0;
    if(t < 1.0/6.0) return p + (q - p) * 6.0 * t;
    if(t < 1.0/2.0) return q;
    if(t < 2.0/3.0) return p + (q - p) * (2.0/3.0 - t) * 6.0;
    return p;
}

vec3 hslToRgb(float h, float s, float l){
    float r, g, b;
    if(s == 0.0){
        r = g = b = l; // achromatic
    }else{
        float q = l < 0.5 ? l * (1.0 + s) : l + s - l * s;
        float p = 2.0 * l - q;
        r = hue2rgb(p, q, h + 1.0/3.0);
        g = hue2rgb(p, q, h);
        b = hue2rgb(p, q, h - 1.0/3.0);
    }

    return vec3(r, g, b);
}

vec3 rgbToHsl(float r, float g, float b) {
    float max = Max(r, Max(g, b));
    float min = Min(r, Min(g, b));
    float h, s, l = (max + min) / 2.0;

    if(max == min){
        h = s = 0.0; // achromatic
    }else{
        float d = max - min;
        s = l > 0.5 ? d / (2.0 - max - min) : d / (max + min);
        if (max == r) h = (g - b) / d + (g < b ? 6.0 : 0.0);
        if (max == g) h = (b - r) / d + 2.0;
        if (max == b) h = (r - g) / d + 4.0;
        h /= 6.0;
    }

    return vec3(h, s, l);
}

void main()
{
    vec4 materialColor = texture2D(texture, gl_PointCoord);
//    vec3 hsl = rgbToHsl(materialColor.x, materialColor.y, materialColor.z);
//    hsl.y = 0.1;
//    vec4 rgba = vec4(hslToRgb(hsl.x, hsl.y, hsl.z),1.0);
	gl_FragColor = color * /*rgba*/materialColor;
}
