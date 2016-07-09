/*
 * Copyright (c) 2016 Vegard IT GmbH, http://vegardit.com
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package hx.doctest.tests;

import hx.doctest.DocTestRunner;

/**
 * Performs doc-testing with DocTestRunner.
 * 
 * @author Sebastian Thomschke, Vegard IT GmbH
 */
@:build(hx.doctest.DocTestGenerator.generateDocTests("test"))
class DocTestTest extends DocTestRunner {

    public static function main() {
        var runner = new DocTestTest();
        runner.runAndExit(20 /* number of expected test cases */);
    }
    
    function new() {
        super();
    }
    
    /**
     * Manually added test method to do some additional non-doctest based testing
     */
    @:keep
    function testManual() {
        assertEquals("a", "a");
        try {
            /*
             * assigning null not on first assignment to make code work in Lua, otherwise
             * the block will be transpiled into `nil:toLowerCase()` which doesn't compile in Lua
             */
            var s = ""; 
            s = null;
            s.toLowerCase(); // throws NPE ... except on PHP
            #if !php
            fail(); // should never be reached
            #end
        } catch (e:Dynamic) {
            // expected
        }
    }
}
