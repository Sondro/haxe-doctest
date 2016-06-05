/*
 * Copyright (c) 2016 Vegard IT GmbH, http://vegardit.com
 * 
 * This software may be modified and distributed under the terms
 * of the MIT license. See the LICENSE.txt file for details.
 */
package hx.doctest.example;

/**
 * @author Sebastian Thomschke, Vegard IT GmbH
 */
class ExampleTools {
    
    /**
     * Returns a new array with size <b>times</b> filled with <b>item</b>.
     * <br/>
     * <b>Examples:</b>
     * <pre><code>
     * >>> ExampleTools.toArray("foo", 2)   == [ "foo", "foo" ]
     * >>> ExampleTools.toArray("foo", 1)   == [ "foo" ]
     * >>> ExampleTools.toArray("foo", 0)   == []
     * >>> ExampleTools.toArray(null, 0)    == []
     * >>> ExampleTools.toArray("", 0)      == []
     * </code></pre>
     */
    public static function toArray<T>(item:T, times:Int):Array<T> {
        var arr = [];
        for (i in 0...times) {
            arr.push(item);
        }
        return arr;
    }
}
