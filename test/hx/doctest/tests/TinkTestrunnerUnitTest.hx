/*
 * Copyright (c) 2016-2017 Vegard IT GmbH, http://vegardit.com
 * SPDX-License-Identifier: Apache-2.0
 */
package hx.doctest.tests;

import hx.doctest.DocTestGenerator;
import tink.core.Promise;
import tink.testrunner.Suite;
import tink.testrunner.Runner;

/**
 * Performs doc-testing with Tink Testrunner.
 *
 * @author Sebastian Thomschke, Vegard IT GmbH
 */
@:build(hx.doctest.DocTestGenerator.generateDocTests("test"))
class TinkTestrunnerUnitTest extends Suite.BasicSuite {

    public static function main() {
        Runner.run(new TinkTestrunnerUnitTest());
    }

    function new() {
        super({name: Type.getClassName(Type.getClass(this))}, []);
    }

}
