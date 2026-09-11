---
layout: page_content
link_title: OpenJDK Announcement
permalink: "/2022/openjdk-announcement/"
toc_group: java
title: OpenJDK Announcement
---

<section class="">
  <div class="wrapper">
    <div class="content content--home">
      <div class="announcepage">
        <div class="container">
          <div class="announcepage__row">
            <div class="announcepage__body">
              <h1 class="announcepage__title">Oracle contributing GraalVM Community Edition Java Code to OpenJDK</h1>
              <div class="announcepage__date">
                <h5>October 25, 2022</h5>
              </div>
            </div>
            <div class="announcepage__image">
              <img src='{{ "/resources/img/announcements/java-duke.png" | relative_url }}' alt="Oracle contributing GraalVM CE Java code to the OpenJDK">
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="content-section">
  <div class="wrapper">
    <div class="announcepage__section">
      <div class="container">
        <!-- <h2 class="ni-libs-frameworks__title">Oracle Contributing GraalVM Community Edition Java Code to OpenJDK</h2> -->
        <div class="announcepage__text">
          <h5 class="announcepage__mod">Oracle is contributing GraalVM Community Edition Java code to OpenJDK to more closely align the development of the GraalVM technologies with that of Java. This will benefit GraalVM and OpenJDK contributors, our partners, customers, and the broader Java ecosystem. It will pave a path towards the elimination of obstacles to wider ecosystem adoption and participation in the development of GraalVM technologies. Some of these obstacles include differences in release schedules, features, and development processes.
          </h5>
          <h5 class="announcepage__mod">By moving GraalVM to the OpenJDK Community, these technologies will be developed using the same successful methods and processes that a large community of companies, organizations, individual developers, and academics have used to move Java forward transparently and predictably for more than a decade.
          </h5>
        </div>
        <h3 class="announcepage__topics">What parts of GraalVM Community Edition does Oracle plan to contribute to the OpenJDK Community?</h3>
          <div class="announcepage__text">
            <h5 class="announcepage__mod">Oracle plans to contribute the most applicable portions of the GraalVM just-in-time (JIT) compiler and Native Image. Oracle does not currently intend to contribute the polyglot technologies supporting other languages such as Python, Ruby, R, and JavaScript. Additional details will follow in the coming months as we move forward through this process.</h5>
          </div>
        <h3 class="announcepage__topics">How does Oracle plan to contribute the code?</h3>
          <div class="announcepage__text">
            <h5 class="announcepage__mod">Oracle plans to contribute the suitable GraalVM technologies into one or more OpenJDK projects, in accordance with the OpenJDK Community processes. Additional details will follow in the coming months.</h5>
          </div>
        <h3 class="announcepage__topics">Which versions of the GraalVM Community Edition code does Oracle plan to migrate?</h3>
          <div class="announcepage__text">
            <h5 class="announcepage__mod">Oracle plans to contribute the GraalVM technologies currently in development. Previous versions of these technologies will remain in the GraalVM GitHub organization.</h5>
          </div>
        <h3 class="announcepage__topics">How will GraalVM Community Edition technologies be developed in the OpenJDK Community?
        </h3>
          <div class="announcepage__text">
            <h5 class="announcepage__mod">GraalVM technologies will be developed in accordance with the methods and processes used in the OpenJDK Community. That means that there will be at least one Project with Committers and Reviewers. If and when a GraalVM technology is ready to become part of a main-line JDK release, a JDK Enhancement Proposal (JEP) will be submitted.</h5>
            <h5 class="announcepage__mod">GraalVM technologies will be developed with the same kind of transparency and predictability that Java developers have come to expect from other Oracle-led Projects in the OpenJDK Community.</h5>
          </div>
        <h3 class="announcepage__topics">Will there be a GraalVM JEP?</h3>
          <div class="announcepage__text">
            <h5 class="announcepage__mod">The JEP planning process provides transparency into JDK development for the entire Java ecosystem. Any sufficiently large feature destined for the JDK main line goes through the JEP Process, since that is how JDK releases are planned in the OpenJDK Community. When suitable portions of the GraalVM technologies are ready to be proposed for inclusion into the main-line JDK source code, they will be accompanied by one or more JEPs.</h5>
          </div> 
        <h3 class="announcepage__topics">Will the GraalVM license change?</h3>
          <div class="announcepage__text">
            <h5 class="announcepage__mod">The plan is to align all the GraalVM technologies with Java both from a release perspective and from a licensing perspective. Additional details will follow in the coming months as we move forward through this process.</h5>
          </div>
        <h3 class="announcepage__topics">Where can I learn more about it?</h3>
          <div class="announcepage__text">
            <h5 class="announcepage__mod">You will be able to learn more about the details of the migration of GraalVM technologies to the OpenJDK Community through the <a href="https://inside.java/">inside.java</a> news aggregation site (which may point to content from multiple sources), as we continue to move forward through this process — just as you would learn about any other interesting bits of Java platform development news.</h5>
          </div>
        <h3 class="announcepage__topics">Will GraalVM Community dev builds be published from the OpenJDK Projects?</h3>
          <div class="announcepage__text">
            <h5 class="announcepage__mod">Oracle-led OpenJDK Projects such as Loom, Panama, and Valhalla all publish Early Access releases on <a href="https://jdk.java.net/">jdk.java.net</a>. Early Access releases of the contributed GraalVM Community Edition technologies may be made available in a similar fashion, as we move forward through this process.</h5>
          </div>
        <h3 class="announcepage__topics">What does the alignment with the Java release model mean in practice?</h3>
          <div class="announcepage__text">
            <h5 class="announcepage__mod">Oracle plans to align future GraalVM releases with the JDK release model:</h5>
            <h5 class="announcepage__mod">
              <ul class="">
                <li>Support for one Java SE Platform Specification per release</li>
                <li>Two feature releases per year</li>
                <li>Four predictable, quarterly Critical Patch Updates annually</li>
                <li>A Long-Term Support Release every two years</li>
              </ul>
            </h5>
            <h5 class="announcepage__mod">The alignment of the release model is planned for CY 2023, pending the migration to OpenJDK development and contribution processes.</h5>
          </div>
        <h3 class="announcepage__topics">What are the plans for Native Image?</h3>
          <div class="announcepage__text">
            <h5 class="announcepage__mod">Oracle plans to contribute the most applicable parts of the GraalVM Native Image implementation to the OpenJDK Community. Once contributed, the Native Image technology would continue to be developed within the scope of an OpenJDK Project, using the same processes and methods as other OpenJDK development. Oracle plans to evolve the Native Image technology in the OpenJDK Community to track the <a href="https://openjdk.org/projects/leyden/">Project Leyden</a> specification as it progresses to pave a path to fully-static images in a future release of the Java SE Platform specification.</h5>
          </div>
        <h3 class="announcepage__topics">I’m a GraalVM CE or GraalVM EE user. Will this change affect me?</h3>
          <div class="announcepage__text">
            <h5 class="announcepage__mod">Ongoing updates for previous GraalVM releases will continue as anticipated with the release schedule getting aligned with Java releases in CY23. This change only affects future development of select open-source GraalVM technologies. Java users will benefit from the alignment of release schedules and cadence as well as easier access to innovation.</h5>
          </div>
      </div>
    </div>
  </div>
</section>
