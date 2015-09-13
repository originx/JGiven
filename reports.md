---
layout: page
title: Report Generation
permalink: /docs/reportgeneration/
---

## Plain Text Reports
By default JGiven outputs plain text reports to the console when executed.
To disable plain text reports set the following Java system property:

{% highlight java %}
jgiven.report.text=false
{% endhighlight %}

## JSON Reports

By default JGiven will generate JSON reports into the `jgiven-reports/json` directory.
JGiven tries to autodetect when it is executed by the Maven surefire plugin and in that case generates the
reports into `target/jgiven-reports/json`.
To disable JSON report generation set the following Java system property:

{% highlight java %}
jgiven.report.enabled=false
{% endhighlight %}

Note that in order to generate HTML reports, JSON reports are required.

## HTML Report
To generate an HTML report you have to run the JGiven report generator with the `html` format option.
The reporter is part of the jgiven-core module. For the HTML output you also need the `jgiven-html5-report` dependency. The report generator can be executed on the command line as follows
(assuming that the jgiven-core and the jgiven-html5-report JAR and all required dependencies are on the Java CLASSPATH)

{% highlight java %}
java com.tngtech.jgiven.report.ReportGenerator \
  --format=html \
  [--sourceDir=<jsonreports>] \
  [--targetDir=<targetDir>] \
{% endhighlight %}

To see the HTML report in action you can have a look at the
[HTML report of JGiven itself]({{ site.baseurl }}/jgiven-report/html5)


### Maven
For Maven there exists a plugin that can be used as follows:

{% highlight java %}
<build>
  <plugins>
    <plugin>
      <groupId>com.tngtech.jgiven</groupId>
      <artifactId>jgiven-maven-plugin</artifactId>
      <version>{{ site.version }}</version>
      <executions>
        <execution>
          <goals>
            <goal>report</goal>
          </goals>
        </execution>
      </executions>
      <configuration>
        <format>html</format>
      </configuration>
    </plugin>
 </plugins>
</build>
{% endhighlight %}

Now run:

{% highlight bash %}
$ mvn verify
{% endhighlight %}

HTML reports are then generated into the `target/jgiven-reports/html` directory.

### Gradle
Currently no Gradle plugin exists for JGiven (feel free to contribute one!). However, you can use the `JavaExec` task instead:
{% highlight groovy %}
task jgivenReport(type: JavaExec, dependsOn: 'test') {
    main = 'com.tngtech.jgiven.report.ReportGenerator'
    args '--targetDir=target/jgiven-reports/html',
         '--format=html'
    classpath = configurations.testCompile
}
{% endhighlight %}

Now run:

{% highlight bash %}
$ gradle jgivenReport
{% endhighlight %}

HTML reports are then generated into the `target/jgiven-reports/html` directory.

Next: [Stages and State Injection]({{site.baseurl}}/docs/stages/)